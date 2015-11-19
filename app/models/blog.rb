class Blog < ActiveRecord::Base
    has_many :comments
    belongs_to :user
    has_many :agrees
    
    def agree_count
        agrees.count
    end
end
