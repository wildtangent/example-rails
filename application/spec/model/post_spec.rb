# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post do
  it('should have a foo method') do
    @post = Post.new
    expect(@post.foo).to eq('foo')
  end
end
