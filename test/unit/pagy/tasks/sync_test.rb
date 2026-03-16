# frozen_string_literal: true

require 'unit/test_helper'
require 'rake'
require 'fileutils'

describe 'SyncTaskTest Specs' do
  let(:destination) { Dir.mktmpdir }

  after do
    FileUtils.rm_rf(destination)
    Rake::Task.clear
  end

  it 'defines the sync task' do
    Pagy::SyncTask.new(:locales, destination)
    assert Rake::Task.task_defined?('pagy:sync:locales')
  end

  it 'runs the sync task and copies files' do
    targets = %w[pagy.js pagy.min.js]
    Pagy::SyncTask.new(:javascript, destination, *targets)

    Rake::Task['pagy:sync:javascript'].invoke

    targets.each do |file|
      _(File.exist?(File.join(destination, file))).must_equal true, "Expected #{file} to be copied"
    end
    %w[pagy.mjs].each do |file|
      _(File.exist?(File.join(destination, file))).must_equal false, "Did NOT expect #{file} to be copied"
    end
  end
end
