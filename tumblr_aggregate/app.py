import envs
import pytumblr
import wget
import schedule
import shutil
import sqlite3
import time
import datetime, os

# Authenticate via OAuth
client = pytumblr.TumblrRestClient(
           envs.consumer_key,
           envs.consumer_secret,
           envs.oauth_token,
           envs.oauth_secret
         )

conn = sqlite3.connect(envs.sqlite_path)
c = conn.cursor()

def is_exists(reb):
    c.execute("SELECT id FROM aggregate WHERE id = {}".format(reb["id"]))
    if c.fetchone() == None:
        c.execute("INSERT INTO aggregate VALUES ({}, '{}', '{}', DATETIME('now', 'localtime'))".format(
            reb["id"], reb["short_url"], ""
            ))
        conn.commit()
        return False
    else:
        return True

def create_dir(dn):
    if os.path.exists(dn) == False:
        os.makedirs(dn)


def main():
    board = client.dashboard()
    
    photos = list(filter(lambda r: r["type"] == "photo", board["posts"]))
    #print(photos[0])
    
    dn = envs.storage_path + '/' + str(datetime.date.today()).replace('-', '')
    create_dir(dn)
    
    for p in photos:
        if is_exists(p):
            continue
    
        for r in p["photos"]:
            url = r["original_size"]["url"]
            if url.split(".")[-1] in ["jpg", "jpeg", "png"]:
                print(url)
                try:
                    fn = wget.download(url)
                    shutil.move(fn, dn)
                except Exception:
                    print(f'exception occurred: url={url}')


if __name__ == '__main__':

    schedule.every(10).minutes.do(main)

    while True:
        schedule.run_pending()
        time.sleep(1)
