require 'rails_helper'

RSpec.feature 'Tag search', type: :feature do
  background do
    @post = create(:post)
    @post.tag_list.add('foo, bar, baz')
    @post.save!
  end

  scenario 'User searches for tags' do
    visit '/tags'

    fill_in 'tag_search[tag_list]', with: 'foo'
    check 'tag_search[fuzzy]'
    click_on submit(:tag_search)

    expect(page).to have_text(@post.title)
  end
end
