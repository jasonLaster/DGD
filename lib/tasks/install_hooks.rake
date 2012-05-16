task :install_hooks do
  hooks = Dir.glob('git-hooks/*')
  hooks.each do |target|
    file = target.split('/').last
    puts "ln -sf ../#{target} .git/hooks/#{file}"
    `ln -sf ../../#{target} .git/hooks/#{file}`
    `chmod +x .git/hooks/#{file}`
  end
  puts "Installed git hooks."
end