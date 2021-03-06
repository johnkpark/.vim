#!/usr/bin/etc ruby

git_bundles = [
'git://github.com/majutsushi/tagbar.git',
'git://github.com/scrooloose/nerdtree.git',
'git://github.com/mileszs/ack.vim.git',
'git://github.com/kien/ctrlp.vim.git',
'https://github.com/davidhalter/jedi-vim.git',
'https://github.com/jmcantrell/vim-virtualenv.git',
'git://vim-latex.git.sourceforge.net/gitroot/vim-latex/vim-latex',
'https://github.com/hail2u/vim-css3-syntax.git',
'https://github.com/groenewege/vim-less',
'git://github.com/dbakker/vim-projectroot.git',
'https://github.com/scrooloose/nerdcommenter.git',
'https://github.com/Lokaltog/powerline.git/',
'https://github.com/editorconfig/editorconfig-vim.git',
'https://github.com/tpope/vim-fugitive.git',
'https://github.com/scrooloose/syntastic.git',
'https://github.com/kchmck/vim-coffee-script.git',
'https://github.com/pangloss/vim-javascript.git',
'https://github.com/mxw/vim-jsx.git',
'https://github.com/terryma/vim-multiple-cursors.git',
'https://github.com/terryma/vim-expand-region.git',
'git://github.com/tpope/vim-endwise.git',
]

vim_org_scripts = [
  ["IndexedSearch", "7062",  "plugin"],
  ["jquery",        "12107", "syntax"],
]

require 'fileutils'
require 'open-uri'

bundles_dir = File.join(File.dirname(__FILE__), "bundle")

FileUtils.cd(bundles_dir)

puts "trashing everything"
Dir["*"].each {|d| FileUtils.rm_rf d }

git_bundles.each do |url|
  dir = url.split('/').last.sub(/\.git$/, '')
  puts "unpacking #{url} into #{dir}"
  `git clone #{url} #{dir}`
  FileUtils.rm_rf(File.join(dir, ".git"))
end

vim_org_scripts.each do |name, script_id, script_type|
  puts "downloading #{name}"
  local_file = File.join(name, script_type, "#{name}.vim")
  FileUtils.mkdir_p(File.dirname(local_file))
  File.open(local_file, "w") do |file|
    file << open("http://www.vim.org/scripts/download_script.php?src_id=#{script_id}").read
  end
end
