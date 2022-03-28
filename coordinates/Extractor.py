import re
import json


class Extractor():
    def __init__(self, file_path, output_path, format='DMS'):
        self.file_path = file_path
        self.output_path = output_path
        self.format = format
        self.regex_extract = re.compile("(\D+)(\d+°\d+'\D)\D+(\d+°\d+'\D)")
        self.regex_values = re.compile("(\d+)°(\d+)'([N|S|W|E])")
        self.dataset = {
            'cities': list(),
            'coordinates': list()
        }

    def convert_decimal(self, value_str):
        result = self.regex_values.search(value_str)
        degrees = int(result.group(1))
        minutes = int(result.group(2))
        direction = result.group(3).strip()
        value = round(degrees + (minutes / 60), 3)
        return f'{value} {direction}'

    def convert_coordinate_format(self, latitude_str, longitude_str):
        match self.format:
            case 'DMS':
                return f'{latitude_str} {longitude_str}'
            
            case 'DD':
                longitude_decimal = self.convert_decimal(longitude_str)
                latitude_decimal = self.convert_decimal(latitude_str)
                return f'{latitude_decimal[:-2]}, {longitude_decimal[:-2]}'

            case 'DMM':
                raise Exception('DMM format is not implemented yet')

            case _:
                raise Exception(f'Incorrect coordinate format: {self.format}')

    def extract_dataset(self):
        with open('source.txt', encoding='utf8') as f:
            for line in f.readlines():
                result = self.regex_extract.search(line)
                city_name = result.group(1).strip()
                longitude_str = result.group(2).strip()
                latitude_str = result.group(3).strip()
                coordinate_str = self.convert_coordinate_format(latitude_str, longitude_str)
                self.dataset['cities'].append(city_name)
                self.dataset['coordinates'].append(coordinate_str)

    def save_json_format(self):
        json_output = []
        for index in range(len(self.dataset['cities'])):
            coordinate = {
                'id': index,
                'city': self.dataset['cities'][index],
                'coordinates': self.dataset['coordinates'][index]
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
        output_path='coordinates.json',
        format='DD'
    )
    extractor.extract()
