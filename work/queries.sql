--  ___________  __   __  ___   __  ___________  ___________  _______   _______       ________   ___      ___ 
-- ("     _   ")|"  |/  \|  "| |" \("     _   ")("     _   ")/"     "| /"      \     |"      "\ |"  \    /"  |
--  )__/  \\__/ |'  /    \:  | ||  |)__/  \\__/  )__/  \\__/(: ______)|:        |    (.  ___  :) \   \  //   |
--     \\_ /    |: /'        | |:  |   \\_ /        \\_ /    \/    |  |_____/   )    |: \   ) || /\\  \/.    |
--     |.  |     \//  /\'    | |.  |   |.  |        |.  |    // ___)_  //      /     (| (___\ |||: \.        |
--     \:  |     /   /  \\   | /\  |\  \:  |        \:  |   (:      "||:  __   \     |:       :)|.  \    /:  |
--      \__|    |___/    \___|(__\_|_)  \__|         \__|    \_______)|__|  \___)    (________/ |___|\__/|___|
                                                                                                        
-- Binome 1 : Je soussigné(e), Nom, Prénom, Badin Victor certifie qu’il s’agit d’un travail original et que toutes les sources utilisées ont été indiquées dans leur totalité. Fait à Grenoble le 24/10/2024.
-- Binome 2 : Je soussigné(e), Nom, Prénom, Martins Lucas certifie qu’il s’agit d’un travail original et que toutes les sources utilisées ont été indiquées dans leur totalité. Fait à Grenoble le 24/10/2024.


-- Connect to the database
\connect db_twitter

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--  Q1: Donnez la liste des tweets de [@CampusIoT](https://twitter.com/CampusIoT)

SELECT T.tweetId, T.content, TO_CHAR(T.postTime, 'Day, DD  HH24:MI') AS DATE    -- On sélectione que l'id, le contenu et la date des tweets 
FROM TTweet T INNER JOIN TUserInfo U ON T.userId = U.userId                     -- On lie la table TTweet avec la table TUserInfo pour pouvoir filtrer les tweets par le pseudo 'CampusIoT'.
WHERE U.username = 'CampusIoT';


--  Q2: Donnez la liste des tweets qui [contiennent à la fois le hashtag #postgresql et le hashtag #mysql](https://twitter.com/search?q=%23postgresql%20%23mysql&src=typed_query&f=top)

SELECT tweetId,userId,content                                       
FROM TTweet
WHERE content LIKE '%#mysql%' and content like '%#postgresql%';


--  Q3: Donnez la liste des tweets référencant l'utilisateur @Frigiel

SELECT tweetId,userId,content                                       
FROM TTweet
WHERE content LIKE '%@Frigiel%' ;   -- On vérifie que le contenu du tweet contient @Frigiel' avec LIKE
                                    -- On utilise le '%' pour dire que le pseudo peut être n'importe où dans le contenu du tweet.

--  Q4: Donnez la liste des tweets de @Frigiel antérieurs à 2020 supprimés (retirés) ou modifiés.

SELECT T.tweetId, T.content, T.modifyTime, T.deletedTime        -- On sélectione que l'id, le contenu et la date des tweets 
FROM TTweet T INNER JOIN TUserInfo U ON T.userId = U.userId     -- On lie la table TTweet avec la table TUserInfo pour pouvoir filtrer les tweets par le pseudo 'Frigiel'.
WHERE U.username = 'Frigiel'
  AND T.postTime < '2020-01-01'                                 -- On filtre les tweets antérieurs à 2020
  AND (T.deletedTime IS NOT NULL OR T.modifyTime IS NOT NULL);  -- On filtre les tweets supprimés ou modifiés.


--  Q5: Donnez le fil d'accueil de [@CampusIoT](https://twitter.com/CampusIoT) : ie les tweets des utilisateurs suivis par @CampusIoT ainsi que les tweets des autres utilisateurs contenant [@CampusIoT](https://twitter.com/CampusIoT). Remarque: Pensez à exclure les tweets des utilisateurs suspendus.

-- On récupère l'Id de @CampusIoT
WITH Campus_Id AS (
    SELECT userId
    FROM TUserInfo
    WHERE userName = 'CampusIoT'
),

-- On récupère tous les utilisateurs suivis par @CampusIoT
Campus_Followers AS (
    SELECT F.userId
    FROM TFollow F JOIN Campus_Id C ON F.followerId = C.userId
),

-- On sélectionne les tweets des utilisateurs suivis par @CampusIoT qui ne sont pas suspendus
Tweets_Campus_Followers AS (
    SELECT T.tweetId, T.content, T.userId, T.postTime
    FROM TTweet T
    JOIN Campus_Followers CF ON T.userId = CF.userId
    WHERE T.suspendedTime IS NULL
),

-- On sélectionne les tweets qui mentionnent @CampusIoT des utilisateurs qui ne sont pas suspendus
Tweets_Mention AS (
    SELECT T.tweetId, T.content, T.userId, T.postTime
    FROM TTweet T
    JOIN TUserInfo U ON T.userId = U.userId
    WHERE T.content LIKE '%@CampusIoT%'
      AND T.suspendedTime IS NULL
      AND U.status = TRUE  
)

-- On combine les tweets des suivis et les mentions
SELECT *
FROM Tweets_Campus_Followers
UNION
SELECT *
FROM Tweets_Mention
ORDER BY postTime DESC;

--  Q6: Donnez le nombre de tweets postés dans la dernière heure
--  Q7: Donnez les tweets les plus republiés dans la dernière heure
--  Q8: Donnez les utilisateurs qui suivent à la fois les utilisateurs @realDonaldTrump et @KamalaHarris
--  Q9: Donnez la liste des 'lurkers' : ie les utilisateurs qui ne redigent ni republient des tweets, qui ne suivent personne, et qui n'aiment aucun tweet.
--  Q10: Donnez le nombre moyen de tweets contenant des hashtags par utilisateur

WITH TweetsWithHashtags AS (
    SELECT userId, COUNT(*) AS hashtag_tweet_count
    FROM TTweet
    WHERE POSITION('#' IN content) > 0  -- Vérifie si le tweet contient un hashtag
    GROUP BY userId
),
TotalTweets AS (
    SELECT userId, COUNT(*) AS total_tweet_count
    FROM TTweet
    GROUP BY userId
)

SELECT 
    tt.userId, 
    COALESCE(CAST(th.hashtag_tweet_count AS FLOAT) / tt.total_tweet_count,0) AS moyenne_tweets_avec_hashtags --COALESCE sert pour le cas ou l'utlisateur n'a envoyer que des message sans #
FROM TotalTweets tt
LEFT JOIN TweetsWithHashtags th ON tt.userId = th.userId;

--  Q11: Donnez le nombre moyen de 'likes' des tweets de l'utilisateur [@rdicosmo](https://twitter.com/rdicosmo)
--  Q12: Donnez les utilisateurs qui ont plus de followers que de 'following' 
--  Q13: Donnez les tweets les plus likés dans les dernières 6 heures (en incluant le score de sentiment moyen).
--  Q14: Donnez les tweets qui ont l'objet d'un grand nombre des rapports de comportement inappropriés.
--  Q15: Donnez les tweets qui sont des republications de tweets qui ont l'objet d'un grand nombre des rapports de comportement inappropriés.
--  Q16: Donnez les utilisateurs qui ont aimé le plus de tweets supprimés.

SELECT l.userId, COUNT(*) AS nb_tweet_suppr_like
FROM TLike l
JOIN TTweet t 
ON l.tweetId = t.tweetId
WHERE t.deletedTime IS NOT NULL
GROUP BY l.userId
ORDER BY nb_tweet_suppr_like DESC;

--  Q17: Donnez les utilisateurs qui ont aimé le plus de tweets d'utilisateurs suspendus.

SELECT l.userId, COUNT(*) AS nb_tweet_suspend_like
FROM TLike l
JOIN TTweet t 
ON l.tweetId = t.tweetId
JOIN TUserInfo u
ON u.userId=t.userId
WHERE u.suspendedTime IS NOT NULL
GROUP BY l.userId
ORDER BY nb_tweet_suspend_like DESC;

--  Q18: Donnez le nombre de utilisateurs connectés en même temps qu'au moins 1 de leurs followers.
--  Q19: Donnez les utilisateurs dont le nombre de tweets contenant des images est supérieur à 70%.
--  Q20: Donnez les 10 utilisateurs qui ont fait la blague la plus drôle 😀 (Astuce : le contenu contient un ou plusieurs [Emoji U+1F60x](https://fr.wikipedia.org/wiki/%C3%89moji)).

SELECT U.userId,U.username,count(*) AS score
FROM TUserInfo U
JOIN TTweet T
ON U.userId=T.userID
WHERE t.content like '%😀%'
GROUP BY U.userId
ORDER BY score DESC
LIMIT 10;

--  Q21: Donnez la liste des utilisateurs qui semblent être des trolls ou des bots : ie beaucoup d'abonnés en très peu de temps, des abonnés qui sont eux-même des trolls ou des bots, ...
--  Q22: Donnez la liste des hashtags les plus populaires (aka tendances) ces dernières 24 heures. 


WITH Hashtags AS (
    SELECT
        LOWER(REGEXP_REPLACE(unnest(string_to_array(content, ' ')), '[^#\w]', '', 'g')) AS hashtag, -- string_to_array converti le contenu du tweet en tableau qui est converti en lignes avec unnest. Les lignes sans # sans supprimer avec REGEXP_REPLACE
        postTime
    FROM TTweet
    WHERE postTime >= NOW() - INTERVAL '1 year') -- on a mis 1 ans plutot qu'u)

SELECT hashtag, COUNT(*) AS popularite
FROM Hashtags
WHERE hashtag LIKE '#%'  -- S'assure de sélectionner uniquement les hashtags
GROUP BY hashtag
ORDER BY popularite DESC;


--  Q23: Donnez les tweets qui semblent être générés par un [transformeur GPT](https://fr.wikipedia.org/wiki/Transformeur) (IA générative).
--  Q24: Donnez les medias qui semblent être générés par un [transformeur GPT](https://fr.wikipedia.org/wiki/Transformeur) (IA générative).



-- Bannière générée avec https://manytools.org/hacker-tools/ascii-banner/