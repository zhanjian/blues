class Song < ActiveRecord::Base
  belongs_to :user
  scope :hot_songs, -> { joins(:likeships).
                                       group('songs.id').
                                       order('count(likeships.id) desc').
                                       limit(10) }
end
