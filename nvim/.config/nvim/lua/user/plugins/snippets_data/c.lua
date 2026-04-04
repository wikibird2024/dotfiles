
local ls = require("luasnip")
local s  = ls.snippet
local t  = ls.text_node
local i  = ls.insert_node
local f  = ls.function_node

local function filename()
  return vim.fn.expand("%:t:r")
end

ls.add_snippets("c", {

  --------------------------------------------------------------------
  -- LOGGER TAG
  --------------------------------------------------------------------
  s("tag", {
    t('static const char *TAG = "'),
    f(filename),
    t('";'),
  }),

  --------------------------------------------------------------------
  -- NULL CHECK
  --------------------------------------------------------------------
  s("nll", {
    t("if ("), i(1, "ptr"), t(" == NULL) {"),
    t({"", "    ESP_LOGE(TAG, \"Pointer is NULL\");"}),
    t({"", "    return "}), i(2, "ESP_ERR_INVALID_ARG"), t(";"),
    t({"", "}"}),
  }),

  --------------------------------------------------------------------
  -- ESP_ERR CHECK
  --------------------------------------------------------------------
  s("err", {
    t("esp_err_t err = "), i(1, "func()"), t(";"),
    t({"", "if (err != ESP_OK) {"}),
    t({"", "    ESP_LOGE(TAG, \"Call failed: %s\", esp_err_to_name(err));"}),
    t({"", "    return err;"}),
    t({"", "}"}),
  }),

  --------------------------------------------------------------------
  -- LOGGING
  --------------------------------------------------------------------
  s("logi", { t('ESP_LOGI(TAG, "'), i(1), t('");') }),
  s("logw", { t('ESP_LOGW(TAG, "'), i(1), t('");') }),
  s("loge", { t('ESP_LOGE(TAG, "'), i(1), t('");') }),
  s("logd", { t('ESP_LOGD(TAG, "'), i(1), t('");') }),

  --------------------------------------------------------------------
  -- TASK FUNCTION
  --------------------------------------------------------------------
  s("tfunc", {
    t("static void "), i(1, "task"), t("(void *arg)"),
    t({"", "{"}),
    t({"", "    while (1) {"}),
    t({"", "        "}), i(2, "// loop"),
    t({"", "        vTaskDelay(pdMS_TO_TICKS("}), i(3, "100"), t("));"),
    t({"", "    }"}),
    t({"", "}"}),
  }),

})
