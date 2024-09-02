import requests
import pandas as pd

CLIENT_ID = '61c6e9b8f6d44f29a5fc221d09c82dca'
CLIENT_SECRET = '4cf78e2abaef436caed941dc6ca748fd'

# Fetching the acess token from spotify
def get_spotify_token(CLIENT_ID, CLIENT_SECRET):
    auth_url = 'https://accounts.spotify.com/api/token'
    auth_response = requests.post(auth_url, {
    'grant_type': 'client_credentials',
    'client_id': CLIENT_ID,
    'client_secret': CLIENT_SECRET,
    })
    auth_data = auth_response.json()
    return auth_data['access_token']

def search_track(track_name, artist_name, token):
    query = f"{track_name} artist:{artist_name}"
    url = f"https://api.spotify.com/v1/search?q={query}&type=track"
    response = requests.get(url, headers={
    'Authorization': f'Bearer {token}'
    })
    json_data = response.json()
    try:
        first_result = json_data['tracks']['items'][0]
        track_id = first_result['id']
        return track_id
    except (KeyError, IndexError):
     return None
    

def get_track_details(track_id, token):
    url = f"https://api.spotify.com/v1/tracks/{track_id}"
    response = requests.get(url, headers={
    'Authorization': f'Bearer {token}'
    })
    json_data = response.json()
    image_url = json_data['album']['images'][0]['url']
    return image_url


access_token = get_spotify_token(CLIENT_ID, CLIENT_SECRET)

df_spotify = pd.read_csv('spotify-2023.csv', encoding='ISO-8859-1')


for i, row in df_spotify.iterrows():
    track_id = search_track(row['track_name'], row['artist(s)_name'], access_token)
    if track_id:
        image_url = get_track_details(track_id, access_token)
        df_spotify.at[i, 'image_url'] = image_url


df_spotify.to_csv('updated_file_spotify-2023.csv', index=False)

# print(df_spotify.columns)