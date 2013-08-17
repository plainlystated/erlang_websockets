require 'rake/clean'

SRC = FileList["src/*.erl"]
BEAMS = SRC.pathmap("%{src,ebin}X.beam")
ERLC_FLAGS = ["+warn_unused_vars", "+warn_unused_import"]
BEAM_DIRS = [
  "ebin/",
  "deps/ezwebframe/ebin",
  "deps/cowboy/ebin",
  "deps/ranch/ebin"
]

CLEAN.include("ebin/*.beam")

directory 'ebin'

task :default => :compile
task :compile do
  sh "./rebar get-deps"
  sh "./rebar compile"
end

task :console => :compile do
  sh "erl -pa #{BEAM_DIRS.join(" ")}"
end

task :start => :compile do
  sh "erl -boot start_sasl -config ./elog.config -pa #{BEAM_DIRS.join(" ")} -s erlang_websockets start"
end
