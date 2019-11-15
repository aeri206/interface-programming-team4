import requests
import xlsxwriter
import os
import google.oauth2.credentials
import google_auth_oauthlib.flow
from googleapiclient.discovery import build
from googleapiclient.errors import HttpError
from google_auth_oauthlib.flow import InstalledAppFlow

api_key='AIzaSyAEAKSHlIrIEaI4_B2zk3LoZjCcnGXI664'

next_page_token = ['CDIQAA', 'CGQQAA', 'CJYBEAA']

file_name = input('Enter file name to save: ')

search_word = input('Enter words to search: ')

order_type = input('Enter order type: e.g) date, rating, relevance, title, videoCount, viewCount:  ')

url = 'https://www.googleapis.com/youtube/v3/search?part=snippet' + '&q=' + search_word + '&order=' + order_type + '&maxResults=50&key=' + api_key + '&regionCode=KR'

r = requests.get(url).json()


video_title_list = []
video_id_list = []
# view_list = []
# like_list = []
# comment_list = []
row_list = []

items = r.get('items')

for i in range(len(items)):
  snippet = items[i].get('snippet')
  title = snippet.get('title')
  video_id = items[i].get('id').get('videoId')
  video_title_list.append(title)
  video_id_list.append(video_id)

url = url + '&pageToken=' + next_page_token[0]
r = requests.get(url).json()
items = r.get('items')

for i in range(len(items)):
  snippet = items[i].get('snippet')
  title = snippet.get('title')
  video_id = items[i].get('id').get('videoId')
  video_title_list.append(title)
  video_id_list.append(video_id)

workbook = xlsxwriter.Workbook( file_name + '_data.xlsx')
worksheet = workbook.add_worksheet()
bold = workbook.add_format({'bold': 1})
worksheet.write('A1', '제목', bold)
worksheet.write('B1', '조회 수', bold)
worksheet.write('C1', '좋아요 수', bold)
worksheet.write('D1', '댓글 수', bold)

title_row = 1

for title in (tuple(video_title_list)):
  worksheet.write_string(title_row, 0, title)
  title_row += 1

for i in range(len(video_id_list)):
  video_id = str(video_id_list[i])
  url = 'https://www.googleapis.com/youtube/v3/videos?part=snippet%2CcontentDetails%2Cstatistics&id=' + video_id + '&key=' + api_key
  r = requests.get(url).json()
  items = r.get('items')
  try:
    statistics = items[0].get('statistics')
    viewCount = statistics.get('viewCount')
    likeCount = statistics.get('likeCount')
    commentCount = statistics.get('commentCount')
    individual_row_list = []
    individual_row_list.append(viewCount)
    individual_row_list.append(likeCount)
    individual_row_list.append(commentCount)
    row_list.append(individual_row_list)
    print(individual_row_list)
  except:
    print('error')
    row_list.append([0,0,0])
  # view_list.append(viewCount)
  # like_list.append(likeCount)
  # comment_list.append(commentCount)
expenses =tuple(row_list)
row = 1
col = 1
for views,likes,comments in (expenses):
  worksheet.write(row, col, views)
  worksheet.write(row, col+1, likes)
  worksheet.write(row, col+2, comments)
  row += 1




workbook.close()




print(video_title_list)
print(len(video_title_list))
