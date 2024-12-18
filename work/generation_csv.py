import os
import random
import csv
import datetime
import uuid
import markovify
from tqdm import tqdm

def random_date(start, end, prop):
    start = datetime.datetime.strptime(start, '%Y-%m-%d %H:%M:%S.%f')
    try :
        end = datetime.datetime.strptime(end, '%Y-%m-%d %H:%M:%S.%f')
    except:
        end = datetime.datetime.strptime(end, '%Y')
    return start + prop * (end - start)
def random_date_from_date(start, end, prop):
    try :
        end = datetime.datetime.strptime(end, '%Y-%m-%d %H:%M:%S.%f')
    except:
        end = datetime.datetime.strptime(end, '%Y')
    return start + prop * (end - start)
def random_text(texte,size):
    text_model = markovify.Text(texte)
    return text_model.make_short_sentence(size) 
def random_uuid():
    return str(uuid.uuid4())
def random_bio(size):
    return random_text( """
Coffee lover. Passionate about coding. Full-time dreamer, part-time traveler.
Tech enthusiast. Developer by day, gamer by night. Opinions are my own.
Digital marketer. Avid reader. Always chasing the next big thing.
Cat mom. Foodie. Loves to explore the world one dish at a time.
Entrepreneur. Speaker. Helping others turn their dreams into reality.
Traveler, photographer, and lover of the great outdoors.
Lifelong learner. Data science geek. Believer in the power of AI.
Fitness fanatic. Trying to make the world a better place, one rep at a time.
Writer and storyteller. Sharing my thoughts one tweet at a time.
Just a simple person trying to live a creative life. Dream big!
Music addict. Finding peace in chaos. Welcome to my thoughts.
Bookworm. Dreamer. Making sense of the world through words.
Social media strategist. Turning followers into community.
Tech junkie. Sharing the latest in apps, gadgets, and innovation.
Artist. Finding beauty in the everyday. Always creating.
""",size)

def random_tweet(size):
    tweets = """
Learning Python was the best decision I made this year! 🚀 😀 #Python #Coding #postgresql #mysql @CampusIoT
Just finished a 5k run this morning. Feeling great! 🏃‍♂️💪 #FitnessGoals @CampusIoT
Coffee and coding... the perfect combination for a productive day! ☕💻 #CodeLife #mysql @Frigiel
Excited to start my new project on AI and machine learning! 🤖📊 #AI #ML @CampusIoT
Always believe in yourself. You are capable of amazing things. ✨ 😀 #MotivationMonday @CampusIoT
Trying out this new JavaScript framework... wish me luck! 😅 #CodeNewbie #JS #postgresql #mysql
Weekend plans: Read a good book, drink some tea, and relax. 📚🍵 😀#SelfCare @Frigiel
Got promoted today! Hard work really does pay off. 🎉 #CareerGoals #Grateful @CampusIoT
The new iPhone is sleek, but that price tag though... 💸 #TechTalk  #postgresql @Frigiel
Just watched the latest episode of my favorite show, and I am SHOOK. 😱 😀#TVTime
Traveling opens your mind to new perspectives. Can’t wait for my next adventure! 🌍✈️ #Wanderlust @realDonaldTrump
JavaScript is both a blessing and a curse, depending on the day. 😩 #CodeStruggles #postgresql @CampusIoT
You miss 100% of the shots you don’t take. Go for it! 🏀 #Inspiration #Motivation @CampusIoT
Taking a break from social media for a bit. See you on the other side! ✌️ #DigitalDetox #postgresql 
Machine learning is fascinating. So many possibilities for the future of tech! 🔮 #DataScience #AI #mysql @CampusIoT
Started learning React today, and I must say, it's not as scary as I thought! #postgresql  #WebDev #ReactJS  @realDonaldTrump
Success is not the key to happiness. Happiness is the key to success. 💡 😀 LifeAdvice @CampusIoT
Any good book recommendations? Looking to expand my reading list! 📖 #BookLovers #mysql @realDonaldTrump
Sometimes all you need is a good playlist and some quiet time. 🎧 😀 #MusicTherapy @Frigiel
Coding is 90% Googling and 10% praying it works. 😅 #DeveloperLife #mysql @Frigiel
Embracing the hustle! Every day is a new opportunity to grow. 💪🚀 #EntrepreneurLife @CampusIoT
Just finished watching a documentary on climate change. So eye-opening! 🌍📺 #ClimateAction @Frigiel
Weekend vibes! Time to unwind and recharge for the week ahead. 🌞✨ #WeekendMood @realDonaldTrump
Learning new programming languages keeps my mind sharp! 💻🧠 #LifelongLearning @CampusIoT
Can’t believe it’s already Halloween! 🎃 What are your plans? #SpookySeason @Frigiel
Music has a way of touching the soul. What’s on your playlist today? 🎶❤️ #MusicLovers @CampusIoT
Feeling grateful for friends who inspire me daily. 🥰💖 #FriendshipGoals @Frigiel
There's nothing like a good cup of tea and a great book! 🍵📚 #TeaTime #BookRecommendations @realDonaldTrump
Just submitted my application for a tech conference! Excited! 🚀📄 #Networking @CampusIoT
Spent the day hiking in the mountains. Nature is the best therapy! ⛰️💚 #GetOutside @Frigiel
The latest tech trends are fascinating! What do you think about AI? 🤔💻 #FutureTech @CampusIoT
Just tried a new recipe and it turned out amazing! 🍽️😍 #CookingAdventures @Frigiel
It's a beautiful day to learn something new! What are you studying today? 🌞📚 #KnowledgeIsPower @CampusIoT
Feeling pumped after a great workout session! 💪🔥 #FitnessJourney @Frigiel
Looking forward to the weekend! Any plans? 🎉😊 #FridayFeeling @realDonaldTrump
Attending a webinar on cybersecurity today. Always learning! 🔒💻 #TechSavvy @CampusIoT
Fall is my favorite season! The colors are stunning. 🍂🍁 #AutumnVibes @Frigiel
Making progress on my side project! Persistence pays off. 🚀💻 #SideHustle @CampusIoT
What are your go-to resources for learning programming? 🤓💡 #DevCommunity @Frigiel
Enjoying a quiet evening with a good movie. Perfect way to unwind! 🍿🎬 #MovieNight @realDonaldTrump
Just completed a course on data analysis. Ready to tackle new challenges! 📊💪 #DataDriven @CampusIoT
I love this time of year! The holiday spirit is in the air. 🎄✨ #HolidaySeason @Frigiel
Every day is a new chance to make a difference! 🌟🙌 #Inspiration @CampusIoT
Taking a moment to appreciate the little things in life. 🥰💖 #Gratitude @Frigiel
Learning to balance work and self-care. It's a journey! ⚖️💼 #WorkLifeBalance @CampusIoT
"""

  
    text_model = markovify.Text(tweets)
    res=text_model.make_short_sentence(size)
    if (res==None):
        return "HA"
    return res
    

def choix(choix1 , choix2, proba):
    return choix1 if random.random()<proba else choix2              
def random_reason(size):
    reason = """
    Ce compte publie des propos haineux et incite à la violence.
    Ce contenu contient des informations trompeuses et fausses.
    Ce message est du spam et a été envoyé à plusieurs reprises.
    Le comportement de cet utilisateur est harcelant et menaçant.
    Ce compte utilise des images inappropriées pour un public jeune.
    L'utilisateur propage des théories du complot non fondées.
    Ce compte diffuse du contenu à caractère pornographique.
    L'utilisateur m'a envoyé des messages non sollicités à plusieurs reprises.
    Ce profil usurpe l'identité d'une personne ou d'une organisation.
    Ce message promeut des activités illégales ou dangereuses.
    L'utilisateur a partagé des informations personnelles sans consentement.
    Le contenu de ce compte enfreint les droits d'auteur et la propriété intellectuelle.
    Cette publication contient des insultes racistes ou discriminatoires.
    Ce compte est utilisé pour promouvoir des arnaques ou des fraudes.
    L'utilisateur publie du contenu trompeur qui peut induire les gens en erreur.
    Ce compte publie constamment du spam ou des liens malveillants.
    L'utilisateur encourage à la haine envers une communauté spécifique.
    Ce compte publie du contenu incitant à l'automutilation ou au suicide.
    L'utilisateur a partagé des images de violence explicite.
    Cette personne tente de vendre des produits non autorisés ou frauduleux.
    """
    text_model = markovify.Text(reason)
    res= text_model.make_short_sentence(size)
    if (res==None):
        return "HA"
    return res


def random_date_defaut():
    return random_date("2013-01-01 00:00:00.00", "2024", random.random())
def genere_user_follower(taille, name_file_user,name_file_follower,liste_user, liste_realName):
    with open(name_file_user, 'w', newline='') as file:
        writer = csv.writer(file)
        writer.writerow(["userId","userName","realName","status","otherProfileStuff","creationTime","suspendedTime","deletedTime"])
        for i in tqdm(range(taille)):
            date= random_date_defaut()
            date_suspended= random_date_from_date(date,"2024", random.random())
            date_deleted= random_date_from_date(date_suspended,"2024", random.random())
            writer.writerow([i,liste_user[i],liste_realName[i],random.choice((["true"]*9)+["false"]),
                             random_bio(random.randint(100,300)),date,choix("",date_suspended,0.9),choix("",date_deleted,0.9)])
    with open(name_file_follower, 'w', newline='') as file:
        writer = csv.writer(file)
        writer.writerow(["userId","followerId","followTime","unfollowTime"])
        for i in tqdm(range(taille)):
            for j in range(taille):
                if random.random()<0.2 and i!=j:
                    date= random_date_defaut()
                    writer.writerow([i,j,date,choix("",random_date_from_date(date, "2024",random.random()),0.9)])

def genere_tweet_like(taille, name_file_tweet, name_file_like,name_file_url, name_file_report,name_file_media, liste_user):
    liste_tweet=[]
    with open(name_file_tweet, 'w', newline='') as file:
        writer = csv.writer(file)
        
        writer.writerow(["tweetId","userId","repostTweetId","content","sentimentScore","postTime","modifyTime","suspendedTime","deletedTime"])
        for i in tqdm(range(taille)):
            liste_tweet.append(random_uuid())
            user= random.choice(liste_user)
            #recuperer la date de création du user
            lecture= csv.reader(open("users.csv", "r"))
            date= random_date_defaut()
            fin="2024"
            for rang,row in enumerate(lecture):
                if rang!=0 and int(row[0])==user:
                    if row[7]!="":
                        fin=row[7]
                    date=random_date(row[5], fin, random.random())
                    
                    break
            date_edit= random_date_from_date(date,fin, random.random())
            date_suspended= random_date_from_date(date_edit,fin, random.random())
            date_deleted= random_date_from_date(date_suspended,fin, random.random())
            writer.writerow([liste_tweet[-1], user,
                             "" if (random.random()<0.9 or len(liste_tweet)==0) else random.choice(liste_tweet),random_tweet(280),
                             random.random()*100,date,  choix("",date_edit,0.9), choix("",date_suspended,0.9),choix("",date_deleted,0.9),] )
    with open(name_file_like, 'w', newline='') as file:
        writer = csv.writer(file)
        writer.writerow(["tweetId","userId","likeTime","unlikeTime"])
        for i in tqdm(liste_tweet):
            for j in liste_user:
                if random.random()<0.1:
                    date= random_date_defaut()
                    writer.writerow([i,j,date,choix("",random_date_from_date(date, "2024",random.random()),0.9)])
    with open(name_file_url, 'w', newline='') as file:
        writer = csv.writer(file)
        writer.writerow(["urlId","tweetId","url"])
        for i,j in tqdm(enumerate(liste_tweet)):
            writer.writerow([i,j,"https://twitter.com/"+str(j)])
    with open(name_file_report, 'w', newline='') as file:
        writer = csv.writer(file)
        writer.writerow(["tweetId","reporterId","reportTime","reason"])
        compte=0
        for i in tqdm(range(len(liste_tweet))):
            if random.random()<0.1:
                lecture= csv.reader(open("tweets.csv", "r"))
                for rang,row in enumerate(lecture):
                    if rang!=0 and row[0]==liste_tweet[i]:
                        get_date_tweet=row[5]
                        break
                date= random_date(get_date_tweet,"2024", random.random())
                writer.writerow([liste_tweet[i],compte,date,random_reason(random.randint(50,100))])
                compte+=1
                compte = compte%len(liste_user)
    with open(name_file_media, 'w', newline='') as file:
        writer = csv.writer(file)
        writer.writerow(["mediaId","tweetId","mimeType","size","content","exif","postTime","modifyTime","deletedTime"]) #content : bytea exif: bytea
        for i in tqdm(liste_tweet):
            if random.random()<0.1:
                lecture= csv.reader(open("tweets.csv", "r"))
                for rang,row in enumerate(lecture):
                    if rang!=0 and row[0]==i:
                        date=random_date(row[5],"2024", random.random())
                        break
                date_edit= random_date_from_date(date,"2024", random.random())
                date_deleted= random_date_from_date(date_edit,"2024", random.random())
                size=random.randint(100,1000)
                writer.writerow([random_uuid(),i,random.choice(["image","video"]),size,os.urandom(size).hex(),os.urandom(10).hex(),date,date_edit,date_deleted])

size=100     
def generate_pseudo(prefixes,suffixes,sep):
    return random.choice(prefixes) +sep+ random.choice(suffixes)       
def genearte_liste_user(taille,prefixes,suffixes,sep,unique, add_name_TP=False):
    liste=[]
    if add_name_TP:
        liste.append("Frigiel")
        liste.append("CampusIoT")
        liste.append("realDonaldTrump")
        liste.append("KamalaHarris")
    for i in range(taille):
        user=generate_pseudo(prefixes,suffixes,sep)
        if unique:
            while user in liste:
                user=generate_pseudo(prefixes,suffixes,sep)
        liste.append(user)
    return liste
genere_user_follower(size, "users.csv","followers.csv",genearte_liste_user(size,[
    "Star", "Night", "Shadow", "Cyber", "Dream",
    "Fire", "Ice", "Thunder", "Storm", "Ghost",
    "Phantom", "Silver", "Dark", "Golden", "Crystal",
    "Mystic", "Echo", "Titan", "Frost", "Dragon","Frigiel"
], [
    "Hunter", "Wizard", "King", "Queen", "Knight",
    "Warrior", "Mage", "Assassin", "Lord", "Lady",
    "Rider", "Seeker", "Bard", "Master", "Sage",
    "Ninja", "Paladin", "Fighter", "Demon", "Champion",""
],"",False,True), genearte_liste_user(size,[
    "Alice", "Benjamin", "Clara", "David", "Emma",
    "Florian", "Gabrielle", "Hugo", "Isabelle", "Julien",
    "Katherine", "Lucas", "Mélanie", "Nathan", "Olivia",
    "Paul", "Quentin", "Sophie", "Thomas", "Victor"
],[
    "Dupont", "Martin", "Bernard", "Petit", "Garnier",
    "Leroy", "Moreau", "Laurent", "Simon", "Girard",
    "Cohen", "Rousseau", "Boucher", "Lemoine", "David",
    "Blanchard", "Guillaume", "Marchand", "Faure", "Henry"
]," ",False))
genere_tweet_like(size**2, "tweets.csv","likes.csv", "urls.csv","reports.csv" ,"medias.csv",list(range(size)))
