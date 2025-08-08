# frozen_string_literal: true

usage_string = <<~USAGE
  Usage: add_dep.rb <vcs> <repo> <required> <ref>
USAGE

known_vcs_systems = %i[github gitlab bitbucket]
vcs, repo, required, ref = ARGV

if vcs.nil? || vcs.empty? || repo.nil? || repo.empty? || required.nil? || required.empty?
  puts usage_string
  # puts "Known VCS systems: #{known_vcs_systems.join(', ')}"
  exit 1
end

unless known_vcs_systems.include?(vcs.to_sym)
  puts usage_string
  puts "Known VCS systems: #{known_vcs_systems.join(', ')}"
  exit 1
end

lock_file = required.to_sym.downcase == "true" ? "required" : "optional"
owner, repo_name = repo.split("/")

system "npins --lock-file npins/#{lock_file}.json add #{vcs} #{owner} #{repo_name} #{ref.nil? ? '' : "--branch #{ref}"}"
