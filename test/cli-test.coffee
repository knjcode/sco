'use strict'

assert = require 'power-assert'
exec = require('child_process').exec
pack = require '../package.json'

sco = 'node bin/sco '

# trim last linebreak
t = (str) ->
  str[0...-1]

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



describe 'sco command-line test', ->
  this.timeout 5000

  it 'display version if -v option specified', (done) ->
    exec sco + '-v', (error, stdout, stderr) ->
      assert t(stdout) == pack['version']
      done()

  it 'display help message if -h option specified', (done) ->
    exec sco + '-h', (error, stdout, stderr) ->
      assert.ok t(stdout).match('help')
      done()

describe 'cli encode test', ->
  for algo, testset of encode_testset
    do (algo, testset) ->
      for key, value of testset
        do (key, value) ->
          it algo + ': ' + key + ' -> ' + value, (done) ->
            exec sco + "-e #{algo} \"#{key}\"", (error, stdout, stderr) ->
              assert t(stdout) == value
              done()

describe 'cli decode test', ->
  for algo, testset of decode_testset
    do (algo, testset) ->
      for key, value of testset
        do (key, value) ->
          it algo + ': ' + key + ' -> ' + value, (done) ->
            exec sco + "-d #{algo} \"#{key}\"", (error, stdout, stderr) ->
              assert t(stdout) == value
              done()

describe 'cli encode and decode test using pipes', ->
  it 'echo hello | sco -e base64 | sco -d base64', (done) ->
    test_using_pipe = "echo hello | #{sco} -e base64 | #{sco} -d base64"
    exec test_using_pipe, (error, stdout, stderr) ->
      assert t(stdout) == "hello"
      done()
