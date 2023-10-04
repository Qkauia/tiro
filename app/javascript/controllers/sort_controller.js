import { Controller } from "@hotwired/stimulus"
import Sortable from 'sortablejs';
import { patch} from '@rails/request.js'

// Connects to data-controller="sort"
export default class extends Controller {
  connect() {
    const sortable = new Sortable(this.element, {
      ghostClass: 'drag-ghost',
      onEnd: (e) => {
        const { item, oldIndex, newIndex } = e
        if (oldIndex !== newIndex) {
          const { id } = item.dataset
          this.sortItem(id, newIndex);
        }
      }
    });
  }

  async sortItem(id, newIndex) {
    const endpoint = `/albums/${id}/sort`

    const data = { body: JSON.stringify({ position: newIndex + 1 }) }
    
    const response = await patch( endpoint, data )
    if (response.ok) {
      alert('別推～');
    }else {
      alert('= =|||');
    }
  }
}

