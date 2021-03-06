// Generated by CoffeeScript 1.10.0
(function() {
  var BaseUlr, cheerio, express, request, router;

  express = require('express');

  router = express.Router();

  request = require('superagent');

  cheerio = require('cheerio');

  BaseUlr = 'http://cnodejs.org/';

  router.get('/', function(req, res, next) {
    return request.get(BaseUlr).end(function(err, cres) {
      var $, tags, topics;
      if (err) {
        return next(err);
      }
      $ = cheerio.load(cres.text);
      tags = [];
      $('a.topic-tab').each(function() {
        return tags.push({
          name: $(this).text().trim(),
          href: $(this).attr('href')
        });
      });
      topics = [];
      $('#topic_list div.cell').each(function() {
        var $pt, ptops;
        $pt = $(this).find('div.topic_title_wrapper span').first();
        ptops = {
          "class": $pt.attr('class') ? $pt.attr('class') : '',
          data: $pt.text() ? $pt.text().trim() : ''
        };
        return topics.push({
          user: $(this).find('a.user_avatar img').attr('title').trim(),
          userImg: $(this).find('a.user_avatar img').attr('src').trim(),
          userUrl: BaseUlr + $(this).find('a.user_avatar').attr('href').trim(),
          count_of_replies: $(this).find('span.count_of_replies').text().trim(),
          count_seperator: $(this).find('span.count_seperator').text().trim(),
          count_of_visits: $(this).find('span.count_of_visits').text().trim(),
          last_time: $(this).find('span.last_active_time').text().trim(),
          last_time_href: BaseUlr + $(this).find('a.last_time').attr('href') || '',
          last_time_img: $(this).find('a.last_time img').attr('src') || '',
          put_top: ptops,
          topic_title: $(this).find('a.topic_title').attr('title').trim(),
          topic_href: BaseUlr + $(this).find('a.topic_title').attr('href').trim()
        });
      });
      return res.render('index', {
        title: 'sai',
        tags: tags,
        topics: topics
      });
    });
  });

  module.exports = router;

}).call(this);
