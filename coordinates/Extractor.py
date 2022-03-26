import re
import json


class Extractor():
    def __init__(self, file_path, output_path):
        self.file_path = file_path
        self.output_path = output_path
        self.regex_extract = re.compile("(\D+)(\d+°\d+'\D)\D+(\d+°\d+'\D)")
        self.regex_values = re.compile("(\d+)°(\d+)'([N|S|W|E])")
        self.dataset = {
            'cities': list(),
            'latitude': list(),
            'longitude': list()
        }

    def convert_decimal(self, value_str):
        result = self.regex_values.search(value_str)
        degrees = int(result.group(1))
        minutes = int(result.group(2))
        direction = result.group(3).strip()
        value = round(degrees + (minutes / 60), 3)
        return f'{value} {direction}'

    def extract_dataset(self):
        with open('source.txt', encoding='utf8') as f:
            for line in f.readlines():
                result = self.regex_extract.search(line)
                city_name = result.group(1).strip()
                longitude_str = result.group(2).strip()
                longitude_decimal = self.convert_decimal(longitude_str)
                latitude_str = result.group(3).strip()
                latitude_decimal = self.convert_decimal(latitude_str)
                self.dataset['cities'].append(city_name)
                self.dataset['latitude'].append(latitude_decimal)
                self.dataset['longitude'].append(longitude_decimal)

    def save_json_format(self):
        json_output = []
        for index in range(len(self.dataset['cities'])):
            coordinate = {
                'id': index,
                'city': self.dataset['cities'][index],
                'latitude': self.dataset['latitude'][index],
                'longitude': self.dataset['longitude'][index]
            }
            json_output.append(coordinate)
        with open(self.output_path, 'wb') as output:
            output.write(json.dumps(json_output, ensure_ascii=False, indent=2).encode('utf8'))

    def extract(self):
        self.extract_dataset()
        self.save_json_format()


if __name__ == "__main__":
    extractor = Extractor(
        file_path='source.txt',
        output_path='coordinates.json'
    )
    extractor.extract()
