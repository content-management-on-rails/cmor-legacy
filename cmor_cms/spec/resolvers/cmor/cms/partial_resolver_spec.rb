require 'rails_helper'

module Cmor
  module Cms
    describe PartialResolver do
      subject { Cmor::Cms::PartialResolver.instance }

      describe '#find_templates' do
        before do
          @valid_args = [
            'foo',
            '',
            true,
            { handlers: [:builder, :erb], locale: [:de], formats: [:html] }
          ]

          @template_args = [
            'foo',
            '',
            false,
            { handlers: [:builder, :erb], locale: [:de], formats: [:html] }
          ]
        end

        it { expect(subject).to respond_to :find_templates }
        it 'should return an Array' do
          expect(subject.find_templates(*@valid_args)).to be_a(Array)
        end

        it 'should not return templates' do
          expect(subject.find_templates(*@template_args)).to be_empty
        end

        context 'page lookup'do
          before(:each) do
            @partial = Cmor::Cms::Partial.create! do |record|
              record.pathname = '/'
              record.basename = '_foo'
              record.format   = 'html'
              record.handler  = 'erb'
            end
          end

          it 'should find partials' do
            @args = [
              'foo',
              '',
              true,
              { handlers: [:builder, :erb], locale: [:de], formats: [:html] }
            ]
            expect(subject.find_templates(*@args).size).to eq(1)
          end
        end

        context 'partial in subfolder lookup'do
          before(:each) do
            @partial = Cmor::Cms::Partial.create! do |record|
              record.pathname = '/foo/bar/'
              record.basename = '_baz'
              record.format   = 'html'
              record.handler  = 'erb'
            end
          end

          it 'should find partials' do
            @args = [
              'baz',
              'foo/bar',
              true,
              { handlers: [:builder, :erb], locale: [:de], formats: [:html] }
            ]
            expect(subject.find_templates(*@args).size).to eq(1)
          end
        end

        context 'partial lookup without format'do
          before(:each) do
            @partial = Cmor::Cms::Partial.create! do |record|
              record.pathname = '/'
              record.basename = '_foo'
              record.locale   = ''
              record.format   = ''
              record.handler  = 'textile'
            end
          end

          it 'should find partials' do
            @args = [
              'foo',
              '',
              true,
              { formats: [:html], locale: [:en, :de], handlers: [:textile, :erb, :arb, :builder] }
            ]
            expect(subject.find_templates(*@args).size).to eq(1)
          end
        end
      end

      describe '#initialize_template' do
        it { expect(subject).to respond_to :initialize_template }
        it 'returns an ActionView Template' do
          record = Cmor::Cms::Partial.create! do |record|
            record.pathname = '/'
            record.basename = '_foo'
            record.format   = 'html'
            record.handler  = 'erb'
          end
          details = { handlers: [:builder, :erb], locale: [:de], formats: [:html] }
          expect(subject.initialize_template(record, details)).to be_a(::ActionView::Template)
        end
      end

      describe '#assert_slashs' do
        it { expect(subject).to respond_to :assert_slashs }

        it 'should assert it has slashs on both ends' do
          expect(subject.assert_slashs('foo/bar')).to eq('/foo/bar/')
        end
      end

      describe '#normalize_array' do
        before do
          @valid_args = [
            [1, 2, 3, 4, 5]
          ]
        end
        it { expect(subject).to respond_to :normalize_array }
        it 'should convert all items to strings' do
          result = subject.normalize_array(@valid_args)
          result.each do |r|
            expect(r).to be_a(String)
          end
        end
      end

      describe '#build_source' do
        before(:each) do
          RecordMock = Class.new do
            attr_accessor :body
          end
          @record = RecordMock.new
          @record.body = 'foo'
        end

        it 'should use the body as source' do
          expect(subject.build_source(@record)).to eq(@record.body)
        end
      end
    end
  end
end
