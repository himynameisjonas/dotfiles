require "rake"
require "pathname"

desc "Install the dotfiles"
task :default do
  FileLinker.link_files
  puts "\n   xoxo\n"
end

class FileLinker
  DOTFILES_PATH = Pathname.new(Dir.pwd)
  LINK_PATH = DOTFILES_PATH.join("link")
  HOME_PATH = Pathname.new(ENV["HOME"])

  attr_reader :source_path

  def initialize(source_path)
    @source_path = source_path
  end

  def self.link_files
    files = Dir.glob(LINK_PATH.join("*"), File::FNM_DOTMATCH).reject { |e| e.end_with?("/.", "/..") }
    files.each do |file|
      new(file).handle
    end
  end

  def handle
    if exist?
      if identical?
        puts "identical #{source_path}"
      else
        print "overwrite #{source_path}? [ynq] "
        case $stdin.gets.chomp
        when "y"
          replace_file
        when "q"
          exit
        else
          puts "skipping #{source_path}"
        end
      end
    else
      link_file
    end
  end

  private

  def identical?
    File.identical?(source_path, target_path)
  end

  def exist?
    File.exist?(target_path)
  end

  def target_path
    HOME_PATH.join(file_name)
  end

  def file_name
    File.basename(source_path)
  end

  def replace_file
    FileUtils.rm(target_path)
    link_file
  end

  def link_file
    puts "linking #{source_path}"
    FileUtils.ln_s source_path, target_path, force: true
  end
end
