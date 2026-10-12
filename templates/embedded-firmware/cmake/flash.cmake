# `flash` target: build the firmware, write its .elf to the board, check it, reset.
#
# In the project's CMakeLists.txt (after add_executable):
#     include(cmake/flash.cmake)
#     add_flash_target(${CMAKE_PROJECT_NAME})            # chip from the .ioc
#     add_flash_target(${CMAKE_PROJECT_NAME} CHIP STM32F411RE)
# Then:  cmake --build --preset debug --target flash   (Neovim <leader>cf, just flash)
#
# Tool (FLASH_RUNNER, like Zephyr's `west flash --runner`):
#   auto                 probe-rs when installed and the chip is known, else
#                        STM32CubeProgrammer (default)
#   probe-rs             probe-rs only (any probe; chip from CHIP or the .ioc)
#   stm32cubeprogrammer  STM32_Programmer_CLI over ST-Link only (reads the chip
#                        id itself; found on PATH or in $STM32_PRG_PATH)
#   e.g.  cmake --preset debug -DFLASH_RUNNER=stm32cubeprogrammer
# Both read every write back (verify). A missing tool only breaks `flash`,
# never the build.
#
# Not for an app that runs behind a bootloader: such a project writes its own
# `flash` target with the extra steps (see the spin coater's tools/flash.py).

set(FLASH_RUNNERS auto probe-rs stm32cubeprogrammer)
list(JOIN FLASH_RUNNERS ", " FLASH_RUNNER_NAMES)
set(FLASH_RUNNER auto CACHE STRING "Flash tool: ${FLASH_RUNNER_NAMES}")
set_property(CACHE FLASH_RUNNER PROPERTY STRINGS ${FLASH_RUNNERS})

function(add_flash_target firmware_target)
    cmake_parse_arguments(PARSE_ARGV 1 FLASH "" "CHIP" "")

    if(NOT FLASH_RUNNER IN_LIST FLASH_RUNNERS)
        message(FATAL_ERROR "FLASH_RUNNER='${FLASH_RUNNER}' is unknown. Use one of: ${FLASH_RUNNER_NAMES}")
    endif()

    # CubeMX names the chip in the .ioc, e.g. Mcu.UserName=STM32F746ZGTx;
    # probe-rs accepts that name as it is.
    if(NOT FLASH_CHIP)
        file(GLOB ioc_files "${CMAKE_SOURCE_DIR}/*.ioc")
        if(ioc_files)
            list(GET ioc_files 0 ioc_file)
            file(STRINGS "${ioc_file}" chip_line REGEX "^Mcu\\.UserName=")
            string(REGEX REPLACE "^Mcu\\.UserName=" "" FLASH_CHIP "${chip_line}")
        endif()
    endif()

    find_program(PROBE_RS probe-rs HINTS "$ENV{HOME}/.cargo/bin")
    find_program(STM32_PROGRAMMER STM32_Programmer_CLI HINTS "$ENV{STM32_PRG_PATH}")

    set(can_use_probe_rs OFF)
    if(PROBE_RS AND FLASH_CHIP)
        set(can_use_probe_rs ON)
    endif()

    set(runner "")
    if(FLASH_RUNNER STREQUAL "probe-rs" OR (FLASH_RUNNER STREQUAL "auto" AND can_use_probe_rs))
        set(runner probe-rs)
    elseif(FLASH_RUNNER STREQUAL "stm32cubeprogrammer" OR (FLASH_RUNNER STREQUAL "auto" AND STM32_PROGRAMMER))
        set(runner stm32cubeprogrammer)
    endif()

    set(elf_file "$<TARGET_FILE:${firmware_target}>")
    set(missing_tool "")
    if(runner STREQUAL "probe-rs" AND can_use_probe_rs)
        set(flash_tool "probe-rs, chip ${FLASH_CHIP}")
        set(flash_command
            "${PROBE_RS}" download --verify --chip "${FLASH_CHIP}" "${elf_file}"
            COMMAND "${PROBE_RS}" reset --chip "${FLASH_CHIP}")
    elseif(runner STREQUAL "probe-rs")
        set(missing_tool "probe-rs needs probe-rs installed and a chip (a .ioc or CHIP)")
    elseif(runner STREQUAL "stm32cubeprogrammer" AND STM32_PROGRAMMER)
        set(flash_tool "STM32_Programmer_CLI")
        set(flash_command "${STM32_PROGRAMMER}" -c port=SWD -w "${elf_file}" -v -rst)
    elseif(runner STREQUAL "stm32cubeprogrammer")
        set(missing_tool "STM32_Programmer_CLI not found: put it on PATH or set STM32_PRG_PATH")
    else()
        set(missing_tool "no flash tool: install probe-rs (with a .ioc or CHIP) or set STM32_PRG_PATH")
    endif()

    if(missing_tool)
        set(flash_tool "none: ${missing_tool}")
        set(flash_command
            "${CMAKE_COMMAND}" -E echo "flash: ${missing_tool}, then reconfigure."
            COMMAND "${CMAKE_COMMAND}" -E false)
    endif()
    message(STATUS "flash: ${flash_tool} (FLASH_RUNNER=${FLASH_RUNNER})")

    add_custom_target(flash
        COMMAND ${flash_command}
        USES_TERMINAL
        VERBATIM
        COMMENT "Flashing ${firmware_target} (${flash_tool})")
    add_dependencies(flash ${firmware_target})
endfunction()
