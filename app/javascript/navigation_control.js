document.addEventListener('DOMContentLoaded', function () {
  const sidebar = document.getElementById('sidebar');
  const toggleButton = document.querySelector('.sidebar-toggle');
  const sidebarLinks = sidebar.querySelectorAll('a');

  // ✅ Setup dropdowns for Master Data, Shipments, and Sucursales
  setupDropdownToggle('masterDataToggle', 'masterDataCollapse', 'chevron-icon', 'masterDataExpanded');
  setupDropdownToggle('shipmentsToggle', 'shipmentsCollapse', 'shipmentsChevron', 'shipmentsExpanded');
  setupDropdownToggle('sucursalesToggle', 'sucursalesCollapse', 'sucursalesChevron', 'sucursalesExpanded');

  function setupDropdownToggle(toggleId, collapseId, chevronId, storageKey) {
    const toggle = document.getElementById(toggleId);
    const collapse = document.getElementById(collapseId);
    const chevron = document.getElementById(chevronId);

    if (toggle && collapse) {
      let isExpanded = localStorage.getItem(storageKey) === 'true';

      if (isExpanded) {
        collapse.style.display = 'block';
        chevron.classList.add('rotate');
        toggle.classList.add('text-blue');
      } else {
        collapse.style.display = 'none';
        chevron.classList.remove('rotate');
        toggle.classList.remove('text-blue');
      }

      toggle.addEventListener('click', function (event) {
        event.preventDefault();

        if (collapse.style.display === 'none') {
          collapse.style.display = 'block';
          chevron.classList.add('rotate');
          toggle.classList.add('text-blue');
          localStorage.setItem(storageKey, 'true');
        } else {
          collapse.style.display = 'none';
          chevron.classList.remove('rotate');
          toggle.classList.remove('text-blue');
          localStorage.setItem(storageKey, 'false');
        }
      });
    }
  }

  // ✅ Toggle sidebar visibility on button click
  if (toggleButton) {
    toggleButton.addEventListener('click', function () {
      sidebar.classList.toggle('show');
    });
  }

  // ✅ Collapse sidebar when clicking a sidebar link (except dropdown toggles)
  sidebarLinks.forEach(link => {
    link.addEventListener('click', function (event) {
      if (event.target.closest('.nav-item.dropdown')) {
        return;
      }
      if (window.innerWidth < 992) {
        sidebar.classList.remove('show');
      }
    });
  });

  // ✅ Ensure sidebar visibility updates on window resize
  window.addEventListener('resize', function () {
    if (window.innerWidth >= 992) {
      sidebar.classList.add('show');
      sidebar.classList.remove('hide-mobile');
    } else {
      sidebar.classList.add('hide-mobile');
      sidebar.classList.remove('show');
    }
  });

  // ✅ Set initial visibility based on screen size
  if (window.innerWidth >= 992) {
    sidebar.classList.add('show');
    sidebar.classList.remove('hide-mobile');
  } else {
    sidebar.classList.add('hide-mobile');
    sidebar.classList.remove('show');
  }

  // ✅ Dynamic form submission for filters
  const filterElements = document.querySelectorAll('.filter-trigger');
  const filterForm = document.getElementById('filterForm');

  if (filterElements && filterForm) {
    filterElements.forEach(element => {
      element.addEventListener('change', function () {
        filterForm.submit();
      });
    });
  }
});

function filterSidebarOptions() {
  let input = document.getElementById("sidebarSearch").value.toLowerCase();
  let items = document.querySelectorAll(".sidebar-item");
  let resultsContainer = document.getElementById("searchResults");
  resultsContainer.innerHTML = ""; // Clear previous results

  if (input === "") {
    resultsContainer.classList.add("d-none");
    return;
  }

  items.forEach((item) => {
    let name = item.dataset.name.toLowerCase();
    let link = item.href;

    if (name.includes(input)) {
      let listItem = document.createElement("li");
      listItem.classList.add("list-group-item", "list-group-item-action");
      listItem.textContent = item.dataset.name;
      listItem.onclick = function () {
        window.location.href = link;
      };
      resultsContainer.appendChild(listItem);
    }
  });

  resultsContainer.classList.remove("d-none");
}

document.addEventListener("DOMContentLoaded", function () {
  let currentPath = window.location.pathname;
  let sidebarItems = document.querySelectorAll(".sidebar-item");

  sidebarItems.forEach(item => {
    let itemPath = item.dataset.path;
    if (currentPath === itemPath) {
      item.classList.add("active-sidebar-item");
    }
  });
});
