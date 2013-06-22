class CommentHelp < ActiveRecord::Base
   attr_accessible :comment_id, :user_id, :helpful

   validates :comment_id, presence: true
   validates :user_id, presence: true
   validates :helpful, presence: true
   validates_uniqueness_of :comment_id, :scope => :user_id

   belongs_to :comment

end
