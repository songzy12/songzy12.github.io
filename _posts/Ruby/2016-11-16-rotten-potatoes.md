---
layout: post
title: "Rotten Potatoes"
date: 2016-11-16 15:10:11 +0800
comments: true
categories: Ruby

---

[here](https://github.com/saasbook/hw-indices-performance)

```
bundle install --without production
rake db:create
rake db:migrate
rake db:seed
```

## benchmark

`vi config/routes.rb`

```
match '/benchmark/:type' => 'movies#benchmark', :as => :benchmark
```

```
http://localhost:3000/benchmark/movies
http://localhost:3000/benchmark/moviegoers
```

`vi app/controllers/movies_controller.rb`

```
  def benchmark
    benchType=params[:type]
    @results=[]
    times_to_run=Movie.count/2
    search_movies=Movie.all(:limit=>times_to_run)
    search_goers=Moviegoer.all(:limit=>times_to_run)
    case benchType

    when "movies"
      start_time=Time.now
      search_movies.each do |bench_movie|
         reviews = bench_movie.reviews 
         reviews.each {|r| r}
      end 
      total_time=Time.now - start_time
      @results<<{:action => "movie.reviews", :times_run => times_to_run, :time=>total_time.round(5)}
    when "moviegoers"
      start_time=Time.now    
      search_goers.each do |g| 
         reviews = g.reviews 
         reviews.each {|r| r}
      end 
      total_time=Time.now - start_time
      @results<<{:action => "moviegoer.reviews", :times_run => times_to_run, :time=>total_time.round(5)}
    end 
  end
```

## db

`vi db/seeds.rb:`

```
movie_count=250
review_count=20 
```

```
$ cd db
$ sqlite3 development.sqlite3
sqlite> explain query plan SELECT "reviews".* FROM "reviews" WHERE "reviews"."movie_id" = 1;
0|0|0|SCAN TABLE reviews 
```

## performance

Your task is to add a migration, or migrations that will improve the performance by eliminate the use of table scans for the following two queries:

```
moviegoer.reviews
movie.reviews
```

```
rails console
> movies = Movie.all(:limit=>1)
> movie = movies[0]
> movie.reviews
  Review Load (3.7ms)  SELECT "reviews".* FROM "reviews" WHERE "reviews"."movie_id" = 1
```

Add index of `movie_id`, `moviegoer_id` to reviews.

```
rails generate migration AddIndexToReviews movie_id:integer:index moviegoer_id:integer:index
```

Delete `add_column` line and run the migration. `vi db/migrate/20161116114311_add_index_to_reviews.rb`

```
class AddIndexToReviews < ActiveRecord::Migration
  def change
    add_index :reviews, :movie_id
    add_index :reviews, :moviegoer_id
  end 
end
```

```
sqlite> explain query plan SELECT "reviews".* FROM "reviews" WHERE "reviews"."movie_id" = 1;
0|0|0|SEARCH TABLE reviews USING INDEX index_reviews_on_movie_id (movie_id=?)
```

