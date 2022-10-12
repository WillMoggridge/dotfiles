rule = {
  matches = {
    {
      { "device.name", "equals", "alsa_output.usb-Focusrite_Scarlett_2i2_USB-00.analog-stereo" },
      { "media.class", "matches", "Audio/Sink" },
    },
  },
  apply_properties = {
    ["priority.driver"]        = 2050,
    ["priority.session"]       = 2050,
  },
}
table.insert(alsa_monitor.rules, rule)
rule = {
  matches = {
    {
      { "device.name", "equals", "alsa_input.usb-Focusrite_Scarlett_2i2_USB-00.analog-stereo" },
      { "media.class", "matches", "Audio/Source" },
    },
  },
  apply_properties = {
    ["priority.driver"]        = 2050,
    ["priority.session"]       = 2050,
  },
}
table.insert(alsa_monitor.rules, rule)

-- rule = {
--   matches = {
--     {
--       { "device.name", "equals", "alsa_output.usb-Focusrite_Scarlett_2i2_USB-00.analog-stereo" },
--       { "media.class", "matches", "Audio/Sink" },
--     },
--   },
--   apply_properties = {
--     ["priority.driver"]        = 2000,
--     ["priority.session"]       = 2000,
--   },
-- }
-- table.insert(alsa_monitor.rules, rule)
-- rule = {
--   matches = {
--     {
--       { "device.name", "equals", "alsa_input.usb-Focusrite_Scarlett_2i2_USB-00.analog-stereo" },
--       { "media.class", "matches", "Audio/Source" },
--     },
--   },
--   apply_properties = {
--     ["priority.driver"]        = 2000,
--     ["priority.session"]       = 2000,
--   },
-- }
-- table.insert(alsa_monitor.rules, rule)

rule = {
  matches = {
    {
      { "device.name", "equals", "alsa_card.usb-046d_HD_Pro_Webcam_C920_84D3FADF-02" },
      { "media.class", "matches", "Audio/Source" },
    },
  },
  apply_properties = {
    ["device.disabled"] = true,
  },
}
table.insert(alsa_monitor.rules, rule)
