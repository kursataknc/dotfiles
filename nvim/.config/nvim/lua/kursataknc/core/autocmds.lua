-- Return to the dashboard when the last real buffer is closed (e.g. via
-- <leader>bd after opening a file from the project picker/explorer).
-- dashboard-nvim only shows itself on VimEnter by default; without this,
-- closing the last buffer just leaves an empty [No Name] window.
vim.api.nvim_create_autocmd("BufDelete", {
  group = vim.api.nvim_create_augroup("kursataknc_dashboard_on_empty", { clear = true }),
  callback = function()
    vim.schedule(function()
      -- Counting listed buffers isn't reliable: Neovim's original startup
      -- scratch buffer often lingers around, listed, forever. Instead check
      -- the buffer we actually landed on: only one window, and that window
      -- now shows a plain, empty, unnamed buffer (buftype "", no name, 0-1
      -- lines) -- exactly what's left after closing the last real file.
      if vim.fn.winnr("$") ~= 1 then
        return
      end
      local buf = vim.api.nvim_get_current_buf()
      local first_line = vim.api.nvim_buf_get_lines(buf, 0, 1, false)[1] or ""
      local empty_unnamed = vim.api.nvim_buf_get_name(buf) == ""
        and vim.bo[buf].buftype == ""
        and vim.api.nvim_buf_line_count(buf) <= 1
        and first_line == ""
      if empty_unnamed then
        vim.cmd("Dashboard")
      end
    end)
  end,
})
