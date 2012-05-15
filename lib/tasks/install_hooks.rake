  task :install_hooks do
    hooks = Dir.glob('git-hooks/*')
    hooks.each do |target|
      file = target.split('/').last.split('.symlink').last
      puts "ln -sfn ../#{target} .git/hooks/#{file}"
      `ln -sfn ../../#{target} .git/hooks/#{file}`
      `chmod +x .git/hooks/#{file}`
    end
    puts "Installed git hooks."
  end