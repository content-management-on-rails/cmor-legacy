require 'rails_helper'

RSpec.feature 'Tag search', type: :feature do
  let(:post) { create(:post) }

  background do
    post.tag_list.add('foo, bar, baz')
    post.save!
  end

  scenario 'User searches for tags' do
    visit '/de/tags'

    fill_in 'search[tag_list]', with: 'foo'
    # check 'tag_search[exact]'
    within('#new_search') { find('input[type="submit"]').click }

    expect(page).to have_text(post.title)
  end

  scenario 'User searches for tags as url params' do
    visit '/de/tags/foo'

    expect(page).to have_text(post.title)
  end
end
