-- 1.Show all usernames in the next format
   USE educ;
SELECT CONCAT('First Name: ', FirstName, '; ', 'Last Name: ', LastName, '; ', 'Full name:', FirstName, ' ', LastName)
  From "User";   

-- 2. Order videos by Views count and show videos and weren’t removed first
-- a. First should go videos with the highest views count that are not removed
-- b. Then videos with less views that are not removed
-- c. Then videos with the highest views count that are deleted
-- d. Then videos with the lowest views count that are deleted
   USE educ;
SELECT * 
  FROM Video
 ORDER BY IsDeleted ASC, Views DESC;

-- 3. Find all deleted videos
   USE educ;
SELECT * 
  FROM Video
 WHERE IsDeleted = 1;

-- 4. Find all videos with 3 or more ‘likes’ and 0 ‘dislikes’ that are not deleted
   USE educ;
SELECT * 
  FROM Video
 WHERE Likes >= 3  AND Dislikes = 0 AND IsDeleted = 0;

-- 5. Find all users and their channels.
-- Find all users and their channels. If user doesn’t have channel, we still want to see the user in the results list. If the user has more than one channel, we want to see multiple rows for every channel. Order the results by channel name.
   USE educ;
SELECT FirstName, LastName,  Channel.Title, Channel.Description
  FROM "User"
       LEFT JOIN Channel
       ON "User".Id = Channel.UserId
 ORDER BY Channel.Title;

-- 6. Find all users and show their videos.
-- Find all users and show their videos. Don’t show users that don’t have any videos in their channels. Order them by views count starting from he highest.
   USE educ;
SELECT FirstName, LastName, Channel.Title, Video.Title, Video.Views
  FROM "User"
       JOIN Channel
       ON "User".Id = Channel.UserId
       JOIN Video
       ON Channel.Id = Video.ChannelId
 ORDER BY Video.Views DESC;

-- 7. Calculate number of items inside all playlists in the system
   USE educ;
SELECT COUNT(Id) 
  FROM PlaylistItem;

-- 8. Calculate number of items inside of all playlists of user with name “Test Test”
   USE educ;
SELECT COUNT(PlaylistId) 
  FROM PlaylistItem
       JOIN Playlist
       ON PlaylistItem.PlaylistId = Playlist.Id
       JOIN "User"
       ON Playlist.UserId = "User".Id
 WHERE FirstName = 'Test' AND LastName = 'Test';

-- 9. Calculate count of videos for every channel
   USE educ;
SELECT Channel.Title, COUNT(ChannelId)
  FROM Channel
       JOIN Video
       ON Channel.Id = Video.ChannelId
 GROUP BY Channel.Title;

-- 10. Calculate count of videos for every not deleted user and show users’ full name
   USE educ;
SELECT CONCAT(FirstName, ' ', LastName), COUNT(Video.Title)
  FROM Video
       JOIN Channel
       ON Channel.id = Video.ChannelId
       JOIN "User"
       ON Channel.UserId = "User".Id
 GROUP BY "User".Id, CONCAT(FirstName, ' ', LastName)
 ORDER BY 2 DESC, 1 DESC;

-- 11. Calculate count of likes for every video in the system
   USE educ;
SELECT Video.Title, COUNT(RTNG.Rating)
  FROM Video
       LEFT JOIN (SELECT Rating.Rating, Rating.VideoId 
                    FROM Rating 
                   WHERE RATING != 2) RTNG
       ON Video.Id = RTNG.VideoId
 GROUP BY Video.Title;

-- 12. Calculate count of dislikes for every video in the system
   USE educ;
SELECT Video.Title, COUNT(RTNG.Rating)
  FROM Video
       LEFT JOIN (SELECT Rating.Rating, Rating.VideoId 
                    FROM Rating 
                   WHERE RATING = 2) RTNG
       ON Video.Id = RTNG.VideoId
 GROUP BY Video.Title;

-- 13 Show users who have exactly one channel (no more, no less)
   USE educ;
SELECT CONCAT(FirstName, ' ', LastName) as 'Full Name'
  FROM "User"
 WHERE "User".Id IN (SELECT UserId
		       FROM Channel
		      GROUP BY UserId
		     HAVING COUNT(UserId) = 1);

-- 14. Calculate length of every comment in the system
   USE educ;
SELECT Text, LEN(Text) as SymbolsCount
  FROM Comment;

-- 15. Show only those comments which length is shorter than 35 symbols, show users and videos which they belong to and order them from longer to shorter.
   USE educ;
SELECT Text, CONCAT(FirstName, ' ', LastName) as 'Full Name', Video.Title, LEN(Text) as SymbolsCount
  FROM Comment
       JOIN "User"
       ON Comment.UserId = "User".Id
       JOIN Video
       ON Video.Id = Comment.VideoId
 WHERE LEN(Text) <= 35
 ORDER BY 4 DESC;

-- 16. For every row from Task #15 show how many likes every video has (query from Task #11)
USE educ;
SELECT Text, CONCAT(FirstName, ' ', LastName) as 'Full Name', Video.Title, tLIKE.Likes, LEN(Text) as SymbolsCount
  FROM Comment
       JOIN "User"
       ON Comment.UserId = "User".Id
       JOIN Video
       ON Video.Id = Comment.VideoId
       JOIN (SELECT Video.Title, COUNT(RTNG.Rating) as Likes
	       FROM Video
		    LEFT JOIN (SELECT Rating.Rating, Rating.VideoId 
                                 FROM Rating 
                                WHERE RATING != 2) RTNG
		    ON Video.Id = RTNG.VideoId
	      GROUP BY Video.Title) tLIKE
       ON Video.Title = tLIKE.Title
 WHERE LEN(Text) <= 35
 ORDER BY 5 DESC;

-- 17. For query from Task #13, add the name of the channel to the results
   USE educ;
SELECT CONCAT(FirstName, ' ', LastName) as 'Full Name', Channel.Title
  FROM "User"
       JOIN Channel
       ON "User".id = Channel.UserId
 WHERE "User".Id IN (SELECT UserId
		       FROM Channel
		      GROUP BY UserId
		     HAVING COUNT(UserId) = 1);

-- 18. Show User Names, Video Titles and Channel Titles in the same query like on the screenshot. Also order the items by their ids
USE educ;
SELECT "User".Id, CONCAT(FirstName, ' ', LastName) as Name, 'User' as Type
  FROM "User"
 UNION
SELECT Channel.Id, Channel.Title as Name, 'Channel' as Type
  FROM Channel
 UNION
SELECT Video.Id, Video.Title as Name, 'Video' as Type 
  FROM Video
 ORDER BY Id ASC;