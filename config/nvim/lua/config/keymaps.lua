-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local Util = require("lazyvim.util")
-- This file is automatically loaded by lazyvim.config.init

-- DO NOT USE THIS IN YOU OWN CONFIG!!
local map = Util.safe_keymap_set
-- use `vim.keymap.set` instead

map("n", "1", "0", { remap = false, silent = true })
map("n", "0", "$", { remap = false, silent = true })

map("i", "jj", "<ESC>", { remap = false, silent = true })
