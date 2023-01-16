require "rails_helper"

module Cmor
  module Cms
    describe PageResolver do
      subject { Cmor::Cms::PageResolver.instance }

      describe "#find_templates" do
        before do
          @valid_args = [
            "foo",
            "",
            false,
            {handlers: [:builder, :erb], locale: [:de], formats: [:html]}
          ]

          @partial_args = [
            "foo",
            "",
            true,
            {handlers: [:builder, :erb], locale: [:de], formats: [:html]}
          ]
        end

        it { expect(subject).to respond_to(:find_templates) }
        it "should return an Array" do
          expect(subject.find_templates(*@valid_args)).to be_a(Array)
        end

        it "should not return templates if it searches a partial" do
          expect(subject.find_templates(*@partial_args)).to be_empty
        end

        context "unpublished page lookup" do
          before(:each) do
            @page = Cmor::Cms::Page.create! do |page|
              page.pathname = "/"
              page.basename = "foo"
              page.format = "html"
              page.handler = "erb"
              page.title = "Foo Page"
              page.published = false
            end
          end

          it "should not find unpublished templates" do
            @args = [
              "foo",
              "",
              false,
              {handlers: [:builder, :erb], locale: [:de], formats: [:html]}
            ]
            expect(subject.find_templates(*@args).size).to eq(0)
          end
        end

        context "published page lookup" do
          before(:each) do
            @page = Cmor::Cms::Page.create! do |page|
              page.pathname = "/"
              page.basename = "foo"
              page.format = "html"
              page.handler = "erb"
              page.title = "Foo Page"
              page.published = true
            end
          end

          it "should find templates" do
            @args = [
              "foo",
              "",
              false,
              {handlers: [:builder, :erb], locale: [:de], formats: [:html]}
            ]
            expect(subject.find_templates(*@args).size).to eq(1)
          end
        end

        context "nested page lookup" do
          before(:each) do
            @page = Cmor::Cms::Page.create! do |page|
              page.pathname = "/foo/bar/"
              page.basename = "baz"
              page.format = "html"
              page.handler = "erb"
              page.title = "Foo Page"
              page.published = true
            end
          end

          it "should find templates" do
            @args = [
              "baz",
              "foo/bar",
              false,
              {handlers: [:builder, :erb], locale: [:de], formats: [:html]}
            ]
            expect(subject.find_templates(*@args).size).to eq(1)
          end
        end

        context "page lookup without format" do
          before(:each) do
            @page = Cmor::Cms::Page.create! do |page|
              page.pathname = "/"
              page.basename = "foo"
              page.locale = ""
              page.format = ""
              page.handler = "textile"
              page.title = "h1. A textilized page"
              page.published = true
            end
          end

          it "should find templates" do
            @args = [
              "foo",
              "",
              false,
              {formats: [:html], locale: [:en, :de], handlers: [:textile, :erb, :arb, :builder]}
            ]
            expect(subject.find_templates(*@args).size).to eq(1)
          end
        end
      end

      describe "#initialize_template" do
        it { expect(subject).to respond_to(:initialize_template) }
        it "returns an ActionView Template" do
          record = Cmor::Cms::Page.create! do |page|
            page.pathname = "/"
            page.basename = "foo"
            page.format = "html"
            page.handler = "erb"
            page.title = "Foo Page"
          end
          details = {handlers: [:builder, :erb], locale: [:de], formats: [:html]}
          expect(subject.initialize_template(record, details)).to be_a(::ActionView::Template)
        end
      end

      describe "#assert_slashs" do
        it { expect(subject).to respond_to(:assert_slashs) }

        it "should assert it has slashs on both ends" do
          expect(subject.assert_slashs("foo/bar")).to eq("/foo/bar/")
        end
      end

      #      describe "#normalize_path" do
      #        it { subject.should respond_to :normalize_path }

      #        it "should normalize the path" do
      #          subject.normalize_path("index", "users").should eq("users/index")
      #        end
      #      end

      describe "#normalize_array" do
        before do
          @valid_args = [
            [1, 2, 3, 4, 5]
          ]
        end
        it { expect(subject).to respond_to :normalize_array }
        it "should convert all items to strings" do
          result = subject.normalize_array(@valid_args)
          result.each do |r|
            expect(r).to be_a(String)
          end
        end
      end

      describe "#build_source" do
        before(:each) do
          @sidebar_content_box = build(:cmor_cms_content_box, name: "sidebar")
          @footer_content_box = build(:cmor_cms_content_box, name: "footer")
          @page = Cmor::Cms::Page.new do |page|
            page.body = "foo"
            page.title = "bar"
            page.meta_description = "baz"
            page.content_blocks << build(:cmor_cms_content_block, page: page, content_box: @sidebar_content_box, body: "sidebar content")
            page.content_blocks << build(:cmor_cms_content_block, page: page, content_box: @footer_content_box, body: "footer content")
          end
        end

        it "should add a content for block for the title" do
          expect(subject.build_source(@page)).to include("<% content_for :title do %>", "bar", "<% end %>")
        end

        it "should add a content for block for the meta description" do
          expect(subject.build_source(@page)).to include("<% content_for :meta_description do %>", "baz", "<% end %>")
        end

        it "should add a content for block for the associated sidebar content block" do
          expect(subject.build_source(@page)).to include("<% content_for :footer do %>", "sidebar content", "<% end %>")
        end

        it "should add a content for block for the associated footer content block" do
          expect(subject.build_source(@page)).to include("<% content_for :footer do %>", "footer content", "<% end %>")
        end
      end
    end
  end
end
