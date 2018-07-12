require_relative('models/star')
require_relative('models/movie')
require_relative('models/casting')

# toy_story = Movie.find_by_id(1)
#
# p toy_story.stars()

jennifer = Star.find_by_id(1)

p jennifer.movies()
