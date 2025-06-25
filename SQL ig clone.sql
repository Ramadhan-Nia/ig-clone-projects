USE ig_clone;
SELECT * FROM  users;
SELECT * FROM  photos;
SELECT * FROM  comments;
SELECT * FROM  likes;
SELECT * FROM  tags;
SELECT * FROM  photo_tags;

# 1. Create an ER diagram or draw a schema for the given database.

# 2. We want to reward the user who has been around the longest, Find the 5 oldest users.
SELECT * FROM  users
ORDER BY created_at
LIMIT 5;

# 3.To target inactive users in an email ad campaign, find the users who have never posted a photo.
SELECT u.id, u.username, COUNT(image_url) AS count_post FROM  users u 
LEFT JOIN photos p ON u.id = p.user_id
GROUP BY u.id, u.username
HAVING count_post=0;

# 4.Suppose you are running a contest to find out who got the most likes on a photo. Find out who won?
SELECT p.user_id, l.photo_id, COUNT(l.user_id) AS count_likes FROM  photos p 
LEFT JOIN likes l ON p.id = l.photo_id
GROUP BY p.user_id, l.photo_id
ORDER BY count_likes DESC;

# 5.The investors want to know how many times does the average user post.
SELECT AVG(count_photo) AS avg_post FROM
(SELECT user_id,  COUNT(id) AS count_photo FROM  photos
GROUP BY user_id) AS photo;

# 6.A brand wants to know which hashtag to use on a post, and find the top 5 most used hashtags.
SELECT t.tag_name, COUNT(*) tagnum FROM  photo_tags pt 
JOIN tags t ON pt.tag_id=t.id
GROUP BY t.tag_name
ORDER BY tagnum DESC
LIMIT 5;

# 7.To find out if there are bots, find users who have liked every single photo on the site.
SELECT l.user_id, COUNT(p.id) likenum FROM  photos p 
JOIN likes l ON p.id=l.photo_id
GROUP BY l.user_id
HAVING likenum=257;

# 8.Find the users who have created instagramid in may and select top 5 newest joinees from it?
SELECT username FROM  users
WHERE MONTH(created_at) = 5
ORDER BY created_at DESC
LIMIT 5;

# 9.Can you help me find the users whose name starts with c and ends with any number and have posted the photos as well as liked the photos?
SELECT u.id, u.username, COUNT(p.id) AS count_post, COUNT(l.photo_id) likenum FROM  users u 
LEFT JOIN photos p ON u.id = p.user_id
LEFT JOIN likes l ON u.id = l.user_id
WHERE u.username REGEXP '^c.*[0-9]$'
GROUP BY u.id, u.username
HAVING count_post>0 AND likenum>0;

# 10.Demonstrate the top 30 usernames to the company who have posted photos in the range of 3 to 5.
SELECT u.id, u.username, COUNT(p.id) AS count_post FROM  users u 
LEFT JOIN photos p ON u.id = p.user_id
GROUP BY u.id, u.username
HAVING count_post BETWEEN 3 AND 5
LIMIT 30;