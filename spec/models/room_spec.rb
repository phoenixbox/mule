require 'spec_helper'

describe Room do
  it { should belong_to(:user) }
end
