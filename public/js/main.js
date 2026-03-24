// ==========================================
// Smooth Scroll
// ==========================================
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
        const href = this.getAttribute('href');
        if (href === '#') return;
        
        e.preventDefault();
        const target = document.querySelector(href);
        if (target) {
            target.scrollIntoView({
                behavior: 'smooth',
                block: 'start'
            });
        }
    });
});

// ==========================================
// Search Functionality
// ==========================================
const searchInput = document.querySelector('.search-input');
const searchBtn = document.querySelector('.search-btn');

if (searchBtn && searchInput) {
    searchBtn.addEventListener('click', performSearch);
    searchInput.addEventListener('keypress', (e) => {
        if (e.key === 'Enter') {
            performSearch();
        }
    });
}

function performSearch() {
    const query = searchInput.value.toLowerCase().trim();
    if (!query) return;
    
    // Simple search: scroll to comparison table and highlight matching rows
    const comparisonSection = document.querySelector('#comparison');
    if (comparisonSection) {
        comparisonSection.scrollIntoView({ behavior: 'smooth' });
        
        // Highlight matching rows
        const rows = document.querySelectorAll('.comparison-table tbody tr');
        rows.forEach(row => {
            const text = row.textContent.toLowerCase();
            if (text.includes(query)) {
                row.style.backgroundColor = '#FFF9E6';
                setTimeout(() => {
                    row.style.backgroundColor = '';
                }, 3000);
            }
        });
    }
}

// ==========================================
// Header Scroll Effect
// ==========================================
let lastScroll = 0;
const header = document.querySelector('.header');

window.addEventListener('scroll', () => {
    const currentScroll = window.pageYOffset;
    
    if (currentScroll > 100) {
        header.style.boxShadow = '0 2px 8px rgba(0, 0, 0, 0.1)';
    } else {
        header.style.boxShadow = '0 2px 4px rgba(0, 0, 0, 0.05)';
    }
    
    lastScroll = currentScroll;
});

// ==========================================
// FAQ Accordion Animation
// ==========================================
const faqItems = document.querySelectorAll('.faq-item');

faqItems.forEach(item => {
    const summary = item.querySelector('summary');
    summary.addEventListener('click', (e) => {
        // Close other open FAQs (optional - comment out for multi-open)
        // faqItems.forEach(otherItem => {
        //     if (otherItem !== item && otherItem.hasAttribute('open')) {
        //         otherItem.removeAttribute('open');
        //     }
        // });
    });
});

// ==========================================
// Intersection Observer for Animation
// ==========================================
const observerOptions = {
    threshold: 0.1,
    rootMargin: '0px 0px -50px 0px'
};

const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            entry.target.style.opacity = '1';
            entry.target.style.transform = 'translateY(0)';
        }
    });
}, observerOptions);

// Observe ranking cards
document.querySelectorAll('.ranking-card').forEach(card => {
    card.style.opacity = '0';
    card.style.transform = 'translateY(20px)';
    card.style.transition = 'opacity 0.6s, transform 0.6s';
    observer.observe(card);
});

// Observe guide items
document.querySelectorAll('.guide-item').forEach((item, index) => {
    item.style.opacity = '0';
    item.style.transform = 'translateY(20px)';
    item.style.transition = `opacity 0.6s ${index * 0.1}s, transform 0.6s ${index * 0.1}s`;
    observer.observe(item);
});

// ==========================================
// Table Responsive Scroll Hint
// ==========================================
const tableWrapper = document.querySelector('.table-wrapper');
if (tableWrapper) {
    const table = tableWrapper.querySelector('table');
    
    function checkTableScroll() {
        if (table.scrollWidth > tableWrapper.clientWidth) {
            if (!tableWrapper.classList.contains('scrollable')) {
                tableWrapper.classList.add('scrollable');
                // Add scroll hint
                const hint = document.createElement('div');
                hint.className = 'scroll-hint';
                hint.textContent = '← 横スクロールできます →';
                hint.style.cssText = `
                    text-align: center;
                    padding: 8px;
                    background: #FFF3CD;
                    color: #856404;
                    font-size: 12px;
                    font-weight: 600;
                    border-radius: 4px;
                    margin-bottom: 8px;
                `;
                tableWrapper.parentElement.insertBefore(hint, tableWrapper);
                
                // Remove hint after scroll
                tableWrapper.addEventListener('scroll', () => {
                    if (hint) hint.remove();
                }, { once: true });
            }
        }
    }
    
    checkTableScroll();
    window.addEventListener('resize', checkTableScroll);
}

// ==========================================
// Stats Counter Animation
// ==========================================
function animateCounter(element) {
    const target = element.textContent;
    const isNumber = !isNaN(parseFloat(target));
    
    if (!isNumber) return;
    
    const value = parseFloat(target);
    const duration = 2000;
    const steps = 60;
    const increment = value / steps;
    let current = 0;
    
    const timer = setInterval(() => {
        current += increment;
        if (current >= value) {
            element.textContent = target;
            clearInterval(timer);
        } else {
            if (target.includes('+')) {
                element.textContent = Math.floor(current) + '+';
            } else if (target.includes('%')) {
                element.textContent = Math.floor(current) + '%';
            } else {
                element.textContent = Math.floor(current);
            }
        }
    }, duration / steps);
}

// Animate stats when hero is visible
const heroObserver = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            document.querySelectorAll('.stat-number').forEach(stat => {
                animateCounter(stat);
            });
            heroObserver.disconnect();
        }
    });
}, { threshold: 0.5 });

const hero = document.querySelector('.hero');
if (hero) {
    heroObserver.observe(hero);
}

// ==========================================
// Print friendly
// ==========================================
window.addEventListener('beforeprint', () => {
    // Expand all FAQ items for printing
    faqItems.forEach(item => {
        item.setAttribute('open', '');
    });
});

console.log('🚀 crypto-card.club loaded successfully!');
