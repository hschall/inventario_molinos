document.addEventListener('DOMContentLoaded', function () {
  const sidebar = document.getElementById('sidebar');
  const toggleButton = document.querySelector('.sidebar-toggle');
  const sidebarLinks = sidebar.querySelectorAll('a');
  const dropdownToggles = sidebar.querySelectorAll('.nav-item.dropdown .nav-link');

  // ✅ Master Data Management Toggle
  const masterDataToggle = document.getElementById('masterDataToggle');
  const masterDataCollapse = document.getElementById('masterDataCollapse');
  const chevronIcon = document.getElementById('chevron-icon');

  if (masterDataToggle && masterDataCollapse) {
    let isExpanded = localStorage.getItem('masterDataExpanded') === 'true';

    if (isExpanded) {
      masterDataCollapse.style.display = 'block';
      chevronIcon.classList.add('rotate');
      masterDataToggle.classList.add('text-blue'); // ✅ Apply blue color when expanded
    } else {
      masterDataCollapse.style.display = 'none';
      chevronIcon.classList.remove('rotate');
      masterDataToggle.classList.remove('text-blue'); // ✅ Remove blue color when collapsed
    }

    masterDataToggle.addEventListener('click', function (event) {
      event.preventDefault();

      if (masterDataCollapse.style.display === 'none') {
        masterDataCollapse.style.display = 'block';
        chevronIcon.classList.add('rotate');
        masterDataToggle.classList.add('text-blue'); // ✅ Turn blue
        localStorage.setItem('masterDataExpanded', 'true');
      } else {
        masterDataCollapse.style.display = 'none';
        chevronIcon.classList.remove('rotate');
        masterDataToggle.classList.remove('text-blue'); // ✅ Revert color
        localStorage.setItem('masterDataExpanded', 'false');
      }
    });
  }

  // ✅ Toggle sidebar visibility on button click
  toggleButton.addEventListener('click', function () {
    sidebar.classList.toggle('show');
  });

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
