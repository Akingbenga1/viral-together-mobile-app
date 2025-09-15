import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  final _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedCategory = 'All';

  final List<String> _categories = [
    'All',
    'Influencer Marketing',
    'Social Media',
    'Industry Insights',
    'Tips & Tutorials',
    'Case Studies',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredPosts = _getFilteredPosts();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Blog'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.onBackground,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(32.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppTheme.primaryColor.withOpacity(0.1),
                    AppTheme.secondaryColor.withOpacity(0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.article_outlined,
                    size: 64,
                    color: AppTheme.primaryColor,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Viral Together Blog',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Latest insights, tips, and trends in influencer marketing and the creator economy.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Search Bar
            TextFormField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search blog posts...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                        setState(() => _searchQuery = '');
                      },
                    )
                  : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Theme.of(context).colorScheme.surface,
              ),
              onChanged: (value) {
                setState(() => _searchQuery = value.toLowerCase());
              },
            ),

            const SizedBox(height: 20),

            // Category Filter
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final category = _categories[index];
                  final isSelected = category == _selectedCategory;
                  
                  return Padding(
                    padding: EdgeInsets.only(right: index < _categories.length - 1 ? 12 : 0),
                    child: FilterChip(
                      label: Text(category),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() => _selectedCategory = category);
                      },
                      selectedColor: AppTheme.primaryColor.withOpacity(0.2),
                      checkmarkColor: AppTheme.primaryColor,
                      labelStyle: TextStyle(
                        color: isSelected ? AppTheme.primaryColor : AppTheme.textSecondary,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 32),

            // Featured Post (if no search/filter)
            if (_searchQuery.isEmpty && _selectedCategory == 'All') ...[
              Text(
                'Featured Post',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              
              _buildFeaturedPostCard(
                context: context,
                post: _getMockPosts().first,
              ),

              const SizedBox(height: 32),
            ],

            // Blog Posts
            Text(
              filteredPosts.isEmpty ? 'No posts found' : 'Latest Posts',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            if (filteredPosts.isEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(32.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.article_outlined,
                      size: 48,
                      color: AppTheme.textSecondary,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No posts found',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Try adjusting your search or category filter.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            else
              ...filteredPosts.map((post) => _buildBlogPostCard(
                context: context,
                post: post,
              )).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedPostCard({
    required BuildContext context,
    required Map<String, dynamic> post,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/blog-detail', arguments: post);
      },
      child: Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: NetworkImage(post['imageUrl']),
            fit: BoxFit.cover,
            onError: (error, stackTrace) {},
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(0.7),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  post['category'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                post['title'],
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    post['author'],
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  const Text(
                    ' • ',
                    style: TextStyle(color: Colors.white70),
                  ),
                  Text(
                    post['date'],
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBlogPostCard({
    required BuildContext context,
    required Map<String, dynamic> post,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/blog-detail', arguments: post);
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: Container(
                width: double.infinity,
                height: 160,
                color: AppTheme.primaryColor.withOpacity(0.1),
                child: Icon(
                  Icons.image,
                  size: 48,
                  color: AppTheme.primaryColor.withOpacity(0.5),
                ),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category and Date
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          post['category'],
                          style: TextStyle(
                            color: AppTheme.primaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        post['date'],
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 12),
                  
                  // Title
                  Text(
                    post['title'],
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // Excerpt
                  Text(
                    post['excerpt'],
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.textSecondary,
                      height: 1.5,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Author and Read Time
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
                        child: Text(
                          post['author'].split(' ').map((n) => n[0]).take(2).join(),
                          style: TextStyle(
                            color: AppTheme.primaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            post['author'],
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '${post['readTime']} min read',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppTheme.textSecondary,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: AppTheme.textSecondary,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredPosts() {
    List<Map<String, dynamic>> posts = _getMockPosts();

    // Filter by category
    if (_selectedCategory != 'All') {
      posts = posts.where((post) => post['category'] == _selectedCategory).toList();
    }

    // Filter by search query
    if (_searchQuery.isNotEmpty) {
      posts = posts.where((post) {
        return post['title'].toLowerCase().contains(_searchQuery) ||
               post['excerpt'].toLowerCase().contains(_searchQuery) ||
               post['category'].toLowerCase().contains(_searchQuery);
      }).toList();
    }

    return posts;
  }

  List<Map<String, dynamic>> _getMockPosts() {
    return [
      {
        'id': '1',
        'title': 'The Complete Guide to Influencer Marketing in 2024',
        'excerpt': 'Discover the latest trends, strategies, and best practices for successful influencer marketing campaigns.',
        'category': 'Influencer Marketing',
        'author': 'Sarah Johnson',
        'date': 'Jan 15, 2024',
        'readTime': 8,
        'imageUrl': 'https://example.com/image1.jpg',
      },
      {
        'id': '2',
        'title': 'How to Find Micro-Influencers for Your Brand',
        'excerpt': 'Learn why micro-influencers can be more effective than mega-influencers and how to find the right ones.',
        'category': 'Tips & Tutorials',
        'author': 'Michael Chen',
        'date': 'Jan 12, 2024',
        'readTime': 5,
        'imageUrl': 'https://example.com/image2.jpg',
      },
      {
        'id': '3',
        'title': 'Social Media Algorithm Changes: What Brands Need to Know',
        'excerpt': 'Stay ahead of the curve with insights on recent social media algorithm updates and their impact.',
        'category': 'Social Media',
        'author': 'Emily Rodriguez',
        'date': 'Jan 10, 2024',
        'readTime': 6,
        'imageUrl': 'https://example.com/image3.jpg',
      },
      {
        'id': '4',
        'title': 'Case Study: How Brand X Increased ROI by 300%',
        'excerpt': 'A detailed look at how one brand transformed their influencer marketing strategy for massive results.',
        'category': 'Case Studies',
        'author': 'David Park',
        'date': 'Jan 8, 2024',
        'readTime': 10,
        'imageUrl': 'https://example.com/image4.jpg',
      },
      {
        'id': '5',
        'title': 'The Rise of AI in Influencer Marketing',
        'excerpt': 'Exploring how artificial intelligence is revolutionizing the way we discover and work with influencers.',
        'category': 'Industry Insights',
        'author': 'Lisa Wang',
        'date': 'Jan 5, 2024',
        'readTime': 7,
        'imageUrl': 'https://example.com/image5.jpg',
      },
      {
        'id': '6',
        'title': 'Building Long-term Relationships with Creators',
        'excerpt': 'Why one-off campaigns are less effective than ongoing partnerships and how to build lasting relationships.',
        'category': 'Influencer Marketing',
        'author': 'James Wilson',
        'date': 'Jan 3, 2024',
        'readTime': 6,
        'imageUrl': 'https://example.com/image6.jpg',
      },
    ];
  }
}