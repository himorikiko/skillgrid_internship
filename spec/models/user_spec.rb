require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create :user }

  it { should respond_to :email                  }
  it { should respond_to :encrypted_password     }
  it { should respond_to :remember_created_at    }
  it { should respond_to :sign_in_count          }
  it { should respond_to :current_sign_in_at     }
  it { should respond_to :last_sign_in_at        }
  it { should respond_to :current_sign_in_ip     }
  it { should respond_to :last_sign_in_ip        }
  it { should respond_to :created_at             }
  it { should respond_to :updated_at             }
  it { should respond_to :name                   }
  it { should respond_to :last_name              }


  it { is_expected.to strip_attribute :name  }
  it { is_expected.to strip_attribute :last_name  }
  it { is_expected.to strip_attribute :email }

  # associations
  it { should respond_to :products               }

end
