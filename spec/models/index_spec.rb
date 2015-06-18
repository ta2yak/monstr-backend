require 'rails_helper'

RSpec.describe Index, type: :model do

  it "multi params generate tree" do
    child = Index.find_or_create_by_path(%w[grandparent parent child])
    expect(child.name).to match 'child'
  end

  it "multi params generate tree with parent" do
    child = Index.find_or_create_by_path(%w[grandparent parent child])
    expect(child.parent.name).to match 'parent'
  end

  it "multi tree generate" do
    child = Index.find_or_create_by_path(%w[grandparent parent child])
    child2 = Index.find_or_create_by_path(%w[grandparent parent2 child2])

    expect(child.name).to match 'child'                               # match 3rd node
    expect(child2.name).to match 'child2'                             # match 3rd node
    expect(child.parent.name).to match 'parent'                       # match 2nd node
    expect(child2.parent.name).to match 'parent2'                     # match 2nd node
    expect(child.parent.parent.name).to match 'grandparent'           # match 1st node
    expect(child2.parent.parent.name).to match 'grandparent'          # match 1st node
    expect(child.parent.parent.id).to match child2.parent.parent.id   # eq 1st node == 1st node

  end


end
