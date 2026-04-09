# Search

<input type="text" id="search-input" placeholder="Type to search..." autofocus>

<ul id="search-results"></ul>

<script src="https://unpkg.com/lunr@2.3.9/lunr.min.js"></script>
<script>
(function() {
  var script = document.createElement('script');
  script.src = 'search-index.json';
  script.onload = function() { init(); };
  document.head.appendChild(script);

  function init() {
    var idx = lunr(function() {
      this.ref('url');
      this.field('title', { boost: 10 });
      this.field('content');
      this.field('path', { boost: 5 });

      window.searchData.forEach(function(doc) {
        this.add(doc);
      }, this);
    });

    var input = document.getElementById('search-input');
    var results = document.getElementById('search-results');

    var params = new URLSearchParams(window.location.search);
    if (params.has('q')) {
      input.value = params.get('q');
      doSearch(params.get('q'));
    }

    input.addEventListener('input', function() {
      doSearch(this.value);
    });

    function doSearch(query) {
      results.innerHTML = '';
      if (query.length < 2) return;

      var terms = query.trim().split(/\s+/).map(function(t) {
        return t + '*';
      }).join(' ');

      var hits = idx.search(terms);
      if (hits.length === 0) {
        terms = query.trim().split(/\s+/).map(function(t) {
          return t + '~1';
        }).join(' ');
        hits = idx.search(terms);
      }

      hits.slice(0, 20).forEach(function(hit) {
        var doc = window.searchData.find(function(d) { return d.url === hit.ref; });
        if (!doc) return;

        var li = document.createElement('li');
        var snippet = doc.content.substring(0, 200);
        if (doc.content.length > 200) snippet += '...';
        var href = doc.url + '.html';

        li.innerHTML =
          '<div class="result-path">' + doc.path + '</div>' +
          '<div class="result-title"><a href="' + href + '">' + doc.title + '</a></div>' +
          '<div class="result-snippet">' + snippet + '</div>';

        results.appendChild(li);
      });

      if (hits.length === 0) {
        results.innerHTML = '<li>No results found.</li>';
      }
    }
  }
})();
</script>
