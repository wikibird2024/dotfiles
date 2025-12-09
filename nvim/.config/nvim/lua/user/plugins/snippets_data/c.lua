local ls = require("luasnip")
local s  = ls.snippet
local t  = ls.text_node
local i  = ls.insert_node
local d  = ls.dynamic_node

-- Lấy tên file hiện tại (không có đuôi mở rộng)
local function get_file_name()
  local filename = vim.fn.expand("%:t:r")
  return filename
end

return {

  --------------------------------------------------------------------
  -- LOGGER TAG (tag)
  --------------------------------------------------------------------
  s("tag", {
    t("static const char *TAG = \""), t(get_file_name()), t("\";")
  }),

  --------------------------------------------------------------------
  -- NULL CHECK (nll)
  --------------------------------------------------------------------
  s("nll", {
    t("if ("), i(1, "ptr"), t(" == NULL) {"),
    t({"", "    ESP_LOGE(TAG, \"Pointer ("), t(i(1)), t(") is NULL\");"}),
    t({"", "    return "}), i(2, "ESP_ERR_INVALID_ARG"), t(";"),
    t({"", "}"})
  }),

  --------------------------------------------------------------------
  -- ESP_ERR CHECK (err)
  --------------------------------------------------------------------
  s("err", {
    t("esp_err_t err = "), i(1, "func_call()"), t(";"),
    t({"", "if (err != ESP_OK) {"}),
    t({"", "    ESP_LOGE(TAG, \""}), i(2, "Failed to call func"), t(": %s\", esp_err_to_name(err));"),
    t({"", "    return err;"}),
    t({"", "}"})
  }),

  --------------------------------------------------------------------
  -- LOG INFO / WARN / ERROR / DEBUG (logi/logw/loge/logd)
  --------------------------------------------------------------------
  s("logi", { t("ESP_LOGI(TAG, \""), i(1, "message"), t("\");") }),
  s("logw", { t("ESP_LOGW(TAG, \""), i(1, "warning message"), t("\");") }),
  s("loge", { t("ESP_LOGE(TAG, \""), i(1, "error message"), t("\");") }),
  s("logd", { t("ESP_LOGD(TAG, \""), i(1, "debug message"), t("\");") }),


  --------------------------------------------------------------------
  -- GPIO CONFIG (gpio_cfg)
  --------------------------------------------------------------------
  s("gpio_cfg", {
    t("gpio_config_t cfg = {"),
    t({"", "    .pin_bit_mask = 1ULL << "}), i(1, "GPIO_NUM_X"), t(","),
    t({"", "    .mode = "}), i(2, "GPIO_MODE_OUTPUT"), t(","),
    t({"", "    .pull_up_en = GPIO_PULLUP_DISABLE,"}),
    t({"", "    .pull_down_en = GPIO_PULLDOWN_DISABLE,"}),
    t({"", "    .intr_type = GPIO_INTR_DISABLE,"}),
    t({"", "};"}),
    t({"", "gpio_config(&cfg);"}),
  }),

  --------------------------------------------------------------------
  -- QUEUE SEND (qs)
  --------------------------------------------------------------------
  s("qs", {
    t("if (xQueueSend("), i(1, "queue_handle"), t(", &"), i(2, "item_to_send"),
    t(", pdMS_TO_TICKS("), i(3, "10"), t(")) != pdPASS) {"),
    t({"", "    ESP_LOGW(TAG, \"Queue send timeout\");"}),
    t({"", "}"})
  }),

  --------------------------------------------------------------------
  -- QUEUE RECEIVE (qr)
  --------------------------------------------------------------------
  s("qr", {
    t("if (xQueueReceive("), i(1, "queue_handle"), t(", &"), i(2, "item_buffer"),
    t(", pdMS_TO_TICKS("), i(3, "100"), t(")) == pdPASS) {"),
    t({"", "    "}), i(4, "// Xử lý dữ liệu nhận được"),
    t({"", "} else {"}),
    t({"", "    "}), i(5, "// Không nhận được dữ liệu (timeout)"),
    t({"", "}"})
  }),

  --------------------------------------------------------------------
  -- TASK CREATE (xtask)
  --------------------------------------------------------------------
  s("xtask", {
    t("xTaskCreatePinnedToCore("),
    i(1, "task_func"), t(", "),
    t("\""), i(2, "TaskName"), t("\", "),
    i(3, "4096"), t(", "),
    i(4, "NULL"), t(", "),
    i(5, "5"), t(", "),   
    t("NULL, "),
    i(6, "1"), t(");") 
  }),

  --------------------------------------------------------------------
  -- TASK FUNCTION SKELETON (tfunc)
  --------------------------------------------------------------------
  s("tfunc", {
    t("static void "), i(1, "task_name"), t("(void *arg)"),
    t({"", "{"}),
    t({"", "    "}), i(2, "// Khởi tạo"),
    t({"", "    while (1) {"}),
    t({"", "        "}), i(3, "// Vòng lặp chính"),
    t({"", "        vTaskDelay(pdMS_TO_TICKS("}), i(4, "100"), t("));"),
    t({"", "    }"}),
    t({"", "    vTaskDelete(NULL);"}),
    t({"", "}"})
  }),

  --------------------------------------------------------------------
  -- STRUCT INIT (sinit)
  --------------------------------------------------------------------
  s("sinit", {
    i(1, "struct_type"), t(" "), i(2, "var_name"), t(" = {"),
    t({"", "    ." }), i(3, "field"), t(" = "), i(4, "value"), t(","),
    t({"", "};"})
  }),

  --------------------------------------------------------------------
  -- COMPONENT SKELETON (comp)
  --------------------------------------------------------------------
  s("comp", {
    t("include:"),
    t({"", "  include/"}), i(1, "comp.h"),
    t({"", "  src/"}), t(get_file_name()), t(".c"),
    t({"", "  Kconfig"}),
    t({"", "  CMakeLists.txt"})
  }),

}
