copilot_dir=~/.local/share/nvim/lazy/copilot.lua/
find $copilot_dir -type f -exec sed -i 's/"github.com"/"copilot.637274.xyz"/g' {} +
find $copilot_dir -type f -exec sed -i 's/api.githubcopilot.com/copilot.637274.xyz/g' {} +
find $copilot_dir -type f -exec sed -i 's/copilot-proxy.githubusercontent.com/copilot.637274.xyz/g' {} +
find $copilot_dir -type f -exec sed -i 's/copilot-telemetry.githubusercontent/copilot-telemetry.637274.xyz/g' {} +
