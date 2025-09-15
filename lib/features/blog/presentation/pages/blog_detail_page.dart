import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/theme/app_theme.dart';

class BlogDetailPage extends StatelessWidget {
  final Map<String, dynamic> post;

  const BlogDetailPage({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: CustomScrollView(
        slivers: [
          // App Bar with Hero Image
          SliverAppBar(
            expandedHeight: 300,
            floating: false,
            pinned: true,
            backgroundColor: Theme.of(context).colorScheme.surface,
            foregroundColor: Theme.of(context).colorScheme.onBackground,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppTheme.primaryColor.withOpacity(0.3),
                      AppTheme.secondaryColor.withOpacity(0.3),
                    ],
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.article,
                    size: 80,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.share),
                onPressed: () => _sharePost(context),
              ),
              IconButton(
                icon: const Icon(Icons.bookmark_outline),
                onPressed: () => _bookmarkPost(context),
              ),
            ],
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category and Date
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          post['category'],
                          style: TextStyle(
                            color: AppTheme.primaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        post['date'],
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Title
                  Text(
                    post['title'],
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Author and Read Time
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
                        child: Text(
                          post['author'].split(' ').map((n) => n[0]).take(2).join(),
                          style: TextStyle(
                            color: AppTheme.primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            post['author'],
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '${post['readTime']} min read',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Article Content
                  _buildArticleContent(context),

                  const SizedBox(height: 32),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => _sharePost(context),
                          icon: const Icon(Icons.share),
                          label: const Text('Share'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => _bookmarkPost(context),
                          icon: const Icon(Icons.bookmark_outline),
                          label: const Text('Bookmark'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Related Posts
                  _buildRelatedPosts(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArticleContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Introduction
        Text(
          post['excerpt'],
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppTheme.textSecondary,
            height: 1.5,
            fontStyle: FontStyle.italic,
          ),
        ),

        const SizedBox(height: 24),

        // Article sections
        _buildSection(
          context: context,
          title: 'Introduction',
          content: 'In today\'s rapidly evolving digital landscape, influencer marketing has become one of the most powerful tools for brands to connect with their target audience. This comprehensive guide will walk you through everything you need to know to create successful influencer marketing campaigns in 2024.',
        ),

        _buildSection(
          context: context,
          title: 'Why Influencer Marketing Matters',
          content: 'Influencer marketing offers a unique opportunity to reach engaged audiences through trusted voices. Unlike traditional advertising, influencer partnerships provide authentic storytelling that resonates with consumers on a personal level.',
        ),

        _buildSection(
          context: context,
          title: 'Key Strategies for Success',
          content: 'To maximize the impact of your influencer marketing efforts, focus on building genuine relationships with creators who align with your brand values. Authenticity is key - audiences can quickly identify inauthentic partnerships.',
        ),

        // Quote/Highlight Box
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20.0),
          margin: const EdgeInsets.symmetric(vertical: 24.0),
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppTheme.primaryColor.withOpacity(0.3),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.format_quote,
                color: AppTheme.primaryColor,
                size: 32,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  '"The most successful influencer campaigns are built on authentic relationships and shared values between brands and creators."',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontStyle: FontStyle.italic,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),

        _buildSection(
          context: context,
          title: 'Measuring Success',
          content: 'Track key performance indicators (KPIs) such as engagement rate, reach, conversions, and return on investment (ROI). Use analytics tools to gather insights and optimize future campaigns.',
        ),

        _buildSection(
          context: context,
          title: 'Future Trends',
          content: 'As we move forward, expect to see increased focus on micro-influencers, AI-powered matchmaking, and long-term brand partnerships. Video content, particularly short-form videos, will continue to dominate social media platforms.',
        ),

        _buildSection(
          context: context,
          title: 'Conclusion',
          content: 'Influencer marketing continues to evolve, but the core principles remain the same: authenticity, alignment, and genuine connection with audiences. By following these strategies and staying up-to-date with industry trends, you can create impactful campaigns that drive real results for your brand.',
        ),
      ],
    );
  }

  Widget _buildSection({
    required BuildContext context,
    required String title,
    required String content,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          content,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            height: 1.6,
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildRelatedPosts(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Related Posts',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, index) {
              final relatedPost = _getRelatedPosts()[index];
              
              return Padding(
                padding: EdgeInsets.only(right: index < 2 ? 16 : 0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => BlogDetailPage(post: relatedPost),
                      ),
                    );
                  },
                  child: Container(
                    width: 200,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 100,
                          decoration: BoxDecoration(
                            color: AppTheme.primaryColor.withOpacity(0.1),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                          ),
                          child: Icon(
                            Icons.article,
                            size: 32,
                            color: AppTheme.primaryColor.withOpacity(0.5),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  relatedPost['category'],
                                  style: TextStyle(
                                    color: AppTheme.primaryColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  relatedPost['title'],
                                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const Spacer(),
                                Text(
                                  relatedPost['date'],
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppTheme.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  List<Map<String, dynamic>> _getRelatedPosts() {
    return [
      {
        'id': '2',
        'title': 'How to Find Micro-Influencers for Your Brand',
        'category': 'Tips & Tutorials',
        'author': 'Michael Chen',
        'date': 'Jan 12, 2024',
        'readTime': 5,
        'excerpt': 'Learn why micro-influencers can be more effective than mega-influencers and how to find the right ones.',
      },
      {
        'id': '3',
        'title': 'Social Media Algorithm Changes: What Brands Need to Know',
        'category': 'Social Media',
        'author': 'Emily Rodriguez',
        'date': 'Jan 10, 2024',
        'readTime': 6,
        'excerpt': 'Stay ahead of the curve with insights on recent social media algorithm updates and their impact.',
      },
      {
        'id': '4',
        'title': 'Case Study: How Brand X Increased ROI by 300%',
        'category': 'Case Studies',
        'author': 'David Park',
        'date': 'Jan 8, 2024',
        'readTime': 10,
        'excerpt': 'A detailed look at how one brand transformed their influencer marketing strategy for massive results.',
      },
    ];
  }

  void _sharePost(BuildContext context) {
    Clipboard.setData(ClipboardData(text: 'Check out this blog post: ${post['title']}'));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Post link copied to clipboard'),
        backgroundColor: AppTheme.primaryColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  void _bookmarkPost(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Post bookmarked!'),
        backgroundColor: AppTheme.primaryColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}