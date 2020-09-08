import markdown

if __name__ == '__main__':
    
    file_path = "C:/Users/slo4/Downloads/awesome-python-master/awesome-python-master/README.md"
    #file_path = "/Users/personal/Downloads/awesome-python-master/README.md"

    my_dict = {}
    process = False
    f = open(file_path, 'r')
    lines = f.readlines()
    key = ""
    values = []
    list1 = []
    for line in lines:
        if line == '\n':
            continue
        words = line.split()
        if words[0].startswith('##'):
            new_string = line.replace('##', '')
            if not process:
                process = True
            else:
                my_dict[key] = values
            key = new_string
            values = []
            list1.append(new_string)
        elif len(words) >= 3:
            if words[1].startswith('[') & process:
                values.append(words[1])
    my_dict[key] = values


            
                    


  

