local status1_ok, ls = pcall(require, "luasnip")
local status2_ok, luasnip = pcall(require, "luasnip.loaders.from_snipmate")
if not status1_ok or not status2_ok then
    return
end

ls.filetype_extend("all", { "_" })

luasnip.lazy_load()
luasnip.load({ paths = { "./snippets" } })
