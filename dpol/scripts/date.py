from datetime import datetime

def main():
  date_file = open("./data/DATE.DAT")
  date_string = datetime.now().strftime("%B %d %Y")
  print(date_string)

if __name__ == "__main__":
  main()