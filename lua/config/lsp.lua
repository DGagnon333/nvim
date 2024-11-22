-- Suppress the tsserver deprecation warning from nvim-lspconfig
-- WARN: gives : 
-- 'tsserver is deprecated, use ts_ls instead.
-- Feature will be removed in lspconfig 0.2.1'
local original_notify = vim.notify

-- Override vim.notify
vim.notify = function(msg, log_level, opts)
  -- Check if the message contains the deprecation warning
  if not msg:match('tsserver is deprecated') then
    -- If not, call the original notify function
    original_notify(msg, log_level, opts)
  else
    -- Optionally, you can log the message to a file or do nothing
    -- For now, we do nothing to suppress the warning
  end
end
