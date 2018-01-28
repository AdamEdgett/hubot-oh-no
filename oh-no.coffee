# Description:
#   Display a random post from webcomicname.com
#
# Dependencies:
#   None
#
# Configuration:
#   HUBOT_TUMBLR_API_KEY
#
# Commands:
#   oh no
#
# Author:
#   AdamEdgett

module.exports = (robot) ->
  robot.hear /oh no/i, (msg) ->
    msg.http("http://api.tumblr.com/v2/blog/webcomicname.tumblr.com/posts/photo")
      .query(api_key: process.env.HUBOT_TUMBLR_API_KEY)
      .get() (err, res, body) ->

        if err
          msg.send "Tumblr error: #{err}"
          return

        content = JSON.parse(body)

        if content.meta.status isnt 200
          msg.send "Tumblr error: #{content.meta.msg}"
          return

        posts = content.response.posts
        pos_num = Math.floor(Math.random() * posts.length)

        msg.send posts[pos_num].photos[0].original_size.url
