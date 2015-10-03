require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:product) { create :product }

  it { should respond_to :title                    }
  it { should respond_to :description              }
  it { should respond_to :image                    }

  it { is_expected.to strip_attribute :title       }
  it { is_expected.to strip_attribute :description }

  # associations
  it { should respond_to :user                     }

end
