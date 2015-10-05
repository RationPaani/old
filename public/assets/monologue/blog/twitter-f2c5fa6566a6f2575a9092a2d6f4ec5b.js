(function() {
  window.TwitterWidget = (function() {
    function TwitterWidget() {}

    TwitterWidget.dom_cache = function() {
      this.template = $("#tweet_template");
      return this.latest_tweets = $("#latest_tweets");
    };

    TwitterWidget.callback = function(data) {
      var i, len, results, tweet;
      this.dom_cache();
      results = [];
      for (i = 0, len = data.length; i < len; i++) {
        tweet = data[i];
        results.push(this.add_tweet(tweet));
      }
      return results;
    };

    TwitterWidget.add_tweet = function(tweet) {
      tweet.text = tweet.text.parseTwitter();
      return this.print(tweet);
    };

    TwitterWidget.print = function(tweet) {
      var el;
      el = this.template.clone().attr("id", "");
      el.html(el.html().replace("{{text}}", tweet.text)).show();
      return this.latest_tweets.append(el);
    };

    return TwitterWidget;

  })();

  String.prototype.parseUsername = function() {
    return this.replace(/[@]+[A-Za-z0-9-_]+/g, function(u) {
      var username;
      username = u.replace("@", "");
      return u.link("http://twitter.com/" + username);
    });
  };

  String.prototype.parseHashtag = function() {
    return this.replace(/[#]+[A-Za-z0-9-_]+/g, function(t) {
      var tag;
      tag = t.replace("#", "%23");
      return t.link("http://search.twitter.com/search?q=" + tag);
    });
  };

  String.prototype.parseURL = function() {
    return this.replace(/[A-Za-z]+:\/\/[A-Za-z0-9-_]+\.[A-Za-z0-9-_:%&~\?\/.=]+/g, function(url) {
      return url.link(url);
    });
  };

  String.prototype.parseTwitter = function() {
    return this.parseURL().parseHashtag().parseUsername();
  };

}).call(this);
