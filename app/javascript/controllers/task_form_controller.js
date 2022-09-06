import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="task-form"
export default class extends Controller {
  add() {
    const tag = document.getElementById('input_tag');
    if (tag.value == '') return;
    const input = tag.value;
    tag.value = '';

    const list = document.getElementById('task_tag_list');
    if (list.value == '') list.value += input;
    else list.value += ',' + input;

    this.create_existed_list(input);
  }

  remove() {
    this.element.classList.add('hidden');

    const list = document.getElementById('task_tag_list');
    var tags = list.value.split(',');
    var tags_list = '';
    const rm_tag = this.element.textContent.trim();
    tags.forEach(function(value){
      if (value.trim() != rm_tag) {
        if (tags_list != '') tags_list += ',' + value;
        else tags_list += value;
      }
    });

    list.value = tags_list;
  }

  create_existed_list(input) {
    var new_tag = this.create_new_tag(input);
    const show_list = document.getElementById('tags_list');
    show_list.appendChild(new_tag);
  }

  create_new_tag(input) {
    var new_tag = this.create_span(input);
    var btn = this.create_btn();
    new_tag.appendChild(btn);
    return new_tag;
  }

  create_span(value) {
    var new_tag = document.createElement("span");
    new_tag.setAttribute("data-controller", "task-form");
    var tag_classList = ['m-3', 'text-white', 'bg-blue-700', 'rounded-lg', 
                         'inline-flex', 'items-center']
    new_tag.classList.add(...tag_classList);
    var parag = document.createElement("p");
    parag.classList.add('p-1');
    var text = document.createTextNode(value);
    parag.appendChild(text);
    new_tag.appendChild(parag);
    return new_tag;
  }

  create_btn() {
    var btn = document.createElement("button");
    btn.setAttribute("data-action", "task-form#remove");
    btn.setAttribute("type", "button");
    var btn_classList = ['text-gray-400', 'bg-transparent', 'hover:bg-gray-200', 
                          'hover:text-gray-900', 'rounded-lg', 'text-sm', 'p-1.5',
                          'ml-auto', 'inline-flex', 'items-center']
    btn.classList.add(...btn_classList);

    var svg = this.create_svg();
    btn.appendChild(svg);
    return btn;
  }

  create_svg() {
    const iconSvg = document.createElementNS('http://www.w3.org/2000/svg', 'svg');
    const iconPath = document.createElementNS(
      'http://www.w3.org/2000/svg',
      'path'
    );

    iconSvg.setAttribute('fill', 'currentColor');
    iconSvg.setAttribute('viewBox', '0 0 20 20');
    iconSvg.setAttribute('aria-hidden', 'true');
    iconSvg.classList.add('w-3', 'h-3');

    iconPath.setAttribute(
      'd',
      'M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z'
    );
    iconPath.setAttribute('fill-rule', 'evenodd');
    iconPath.setAttribute('clip-rule', 'evenodd');

    iconSvg.appendChild(iconPath);
    return iconSvg
  }
}
