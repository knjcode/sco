'use strict'

assert = require 'power-assert'
exec = require('child_process').exec
pack = require '../package.json'
eol = require('os').EOL

sco = 'node bin/sco '

encode_testset =
  'ascii':
    '0x61:62:63':'abc'
  'md5':
    'abc':'900150983cd24fb0d6963f7d28e17f72'

decode_testset =
  'hex':
    '616263':'abc'
  'base64':
    'YWJj':'abc'


describe 'sco command-line option test', ->
  it 'display version if -v option specified', (done) ->
    exec sco + '-v', (error, stdout, stderr) ->
      assert stdout is pack['version']+eol
      done()

  it 'display help message if -h option specified', (done) ->
    exec sco + '-h', (error, stdout, stderr) ->
      assert.ok stdout.match('help')
      done()

  it 'list available algorithm if -l enc option specified', (done) ->
    exec sco + "-l enc", (error, stdout, stderr) ->
      assert.ok stdout.match('base64')
      done()

  it 'list available algorithm if -l dec option specified', (done) ->
    exec sco + "-l dec", (error, stdout, stderr) ->
      assert.ok stdout.match('base64')
      done()

describe 'cli encode test', ->
  for algo, testset of encode_testset
    do (algo, testset) ->
      for key, value of testset
        do (key, value) ->
          it algo + ': ' + key + ' -> ' + value, (done) ->
            exec sco + "-e #{algo} \"#{key}\"", (error, stdout, stderr) ->
              assert stdout is value+eol
              done()

  it 'unknown algorithm error', (done) ->
    exec sco + "-e hoge hello", (error, stdout, stderr) ->
      assert stderr is "Error: unknown algorithm specified"+eol
      done()

describe 'cli decode test', ->
  for algo, testset of decode_testset
    do (algo, testset) ->
      for key, value of testset
        do (key, value) ->
          it algo + ': ' + key + ' -> ' + value, (done) ->
            exec sco + "-d #{algo} \"#{key}\"", (error, stdout, stderr) ->
              assert stdout is value
              done()

  it 'unknown algorithm error using pipes', (done) ->
    exec sco + "-d hoge < /dev/null", (error, stdout, stderr) ->
      assert stderr is "Error: unknown algorithm specified"+eol
      done()

describe 'cli encode and decode test using pipes', ->
  it 'echo hello | sco -e base64 | sco -d base64', (done) ->
    test_using_pipe = "echo hello | #{sco} -e base64 | #{sco} -d base64"
    exec test_using_pipe, (error, stdout, stderr) ->
      assert stdout is "hello"+eol
      done()
