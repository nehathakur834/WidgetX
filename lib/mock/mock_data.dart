import 'package:flutter/material.dart';

class MockProduct {
  const MockProduct({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.rating,
    required this.reviewCount,
    this.description = '',
    this.isNew = false,
    this.isFeatured = false,
  });
  final String id, name, category, description;
  final double price, rating;
  final int reviewCount;
  final bool isNew, isFeatured;
}

class MockTransaction {
  const MockTransaction({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.date,
    required this.isCredit,
    required this.icon,
  });
  final String id, title, subtitle, date;
  final double amount;
  final bool isCredit;
  final IconData icon;
}

class MockProperty {
  const MockProperty({
    required this.id,
    required this.title,
    required this.location,
    required this.price,
    required this.beds,
    required this.baths,
    required this.sqft,
    required this.type,
    this.description = '',
    this.isFeatured = false,
  });
  final String id, title, location, type, description;
  final double price;
  final int beds, baths, sqft;
  final bool isFeatured;
}

class MockTask {
  const MockTask({
    required this.id,
    required this.title,
    required this.project,
    required this.priority,
    this.isDone = false,
    required this.dueDate,
    this.description = '',
  });
  final String id, title, project, priority, dueDate, description;
  final bool isDone;
}

class MockPost {
  const MockPost({
    required this.id,
    required this.author,
    required this.handle,
    required this.content,
    required this.timeAgo,
    required this.likes,
    required this.comments,
    this.shares = 0,
    this.imageUrl,
  });
  final String id, author, handle, content, timeAgo;
  final int likes, comments, shares;
  final String? imageUrl;
}

class MockRestaurant {
  const MockRestaurant({
    required this.id,
    required this.name,
    required this.cuisine,
    required this.rating,
    required this.deliveryTime,
    required this.minOrder,
    required this.category,
    required this.menuItems,
    this.isOpen = true,
    this.deliveryFee = 2.99,
  });
  final String id, name, cuisine, deliveryTime, category;
  final double rating, minOrder, deliveryFee;
  final List<MockMenuItem> menuItems;
  final bool isOpen;
}

class MockMenuItem {
  const MockMenuItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    this.isPopular = false,
  });
  final String id, name, description, category;
  final double price;
  final bool isPopular;
}

class MockNotification {
  const MockNotification({
    required this.id,
    required this.title,
    required this.message,
    required this.timeAgo,
    required this.icon,
    this.isRead = false,
  });
  final String id, title, message, timeAgo;
  final IconData icon;
  final bool isRead;
}

class MockChatMessage {
  const MockChatMessage({
    required this.id,
    required this.author,
    required this.message,
    required this.timeAgo,
    required this.isMine,
  });
  final String id, author, message, timeAgo;
  final bool isMine;
}

class MockHotelRoom {
  const MockHotelRoom({
    required this.id,
    required this.name,
    required this.description,
    required this.pricePerNight,
    required this.capacity,
    required this.amenities,
  });
  final String id, name, description;
  final double pricePerNight;
  final int capacity;
  final List<String> amenities;
}

// ─────────────────────────────────────────────────────────────────────────────
// Mock data collections
// ─────────────────────────────────────────────────────────────────────────────

abstract final class MockData {
  // ── Products ────────────────────────────────────────────────────────────────
  static const products = [
    MockProduct(
      id: '1',
      name: 'Wireless Headphones Pro',
      price: 149.99,
      category: 'Electronics',
      rating: 4.8,
      reviewCount: 234,
      description:
          'Experience superior sound quality with 30-hour battery life, '
          'active noise cancellation, and premium comfort for all-day wear.',
      isFeatured: true,
    ),
    MockProduct(
      id: '2',
      name: 'Running Shoes Ultra',
      price: 89.99,
      category: 'Sports',
      rating: 4.6,
      reviewCount: 189,
      description:
          'Lightweight and responsive running shoes with energy-return foam '
          'and breathable mesh upper for maximum performance.',
    ),
    MockProduct(
      id: '3',
      name: 'Minimalist Watch',
      price: 299.00,
      category: 'Accessories',
      rating: 4.9,
      reviewCount: 87,
      description:
          'Swiss movement, sapphire crystal glass, and genuine leather strap. '
          'A timeless piece for every occasion.',
      isNew: true,
    ),
    MockProduct(
      id: '4',
      name: 'Smart Water Bottle',
      price: 45.00,
      category: 'Health',
      rating: 4.4,
      reviewCount: 312,
      description:
          'Tracks your hydration, reminds you to drink, and keeps your '
          'water cold for 24 hours or hot for 12 hours.',
    ),
    MockProduct(
      id: '5',
      name: 'Yoga Mat Premium',
      price: 65.00,
      category: 'Sports',
      rating: 4.7,
      reviewCount: 156,
      description:
          'Non-slip, eco-friendly TPE foam with alignment lines and '
          'carry strap. Perfect for studio or home practice.',
    ),
    MockProduct(
      id: '6',
      name: 'Laptop Stand Adjustable',
      price: 79.99,
      category: 'Office',
      rating: 4.5,
      reviewCount: 203,
      description:
          'Ergonomic aluminum stand with 6 height levels. Compatible with '
          'all laptops 10–17". Reduces neck strain and improves posture.',
      isFeatured: true,
    ),
    MockProduct(
      id: '7',
      name: 'Mechanical Keyboard',
      price: 119.00,
      category: 'Electronics',
      rating: 4.7,
      reviewCount: 445,
      description:
          'Tactile Cherry MX switches, RGB backlight, and compact TKL layout. '
          'USB-C with braided cable.',
      isNew: true,
    ),
    MockProduct(
      id: '8',
      name: 'Foam Roller Pro',
      price: 38.00,
      category: 'Health',
      rating: 4.3,
      reviewCount: 201,
      description:
          'High-density foam roller for muscle recovery and myofascial release. '
          'Grid texture for targeted deep tissue massage.',
    ),
  ];

  // ── Transactions ─────────────────────────────────────────────────────────────
  static const transactions = [
    MockTransaction(
      id: '1',
      title: 'Netflix Subscription',
      subtitle: 'Entertainment',
      amount: 15.99,
      date: 'Today, 9:00 AM',
      isCredit: false,
      icon: Icons.movie_outlined,
    ),
    MockTransaction(
      id: '2',
      title: 'Salary Deposit',
      subtitle: 'Income',
      amount: 5200.00,
      date: 'Yesterday, 12:00 PM',
      isCredit: true,
      icon: Icons.account_balance_outlined,
    ),
    MockTransaction(
      id: '3',
      title: 'Grocery Store',
      subtitle: 'Food & Drinks',
      amount: 84.50,
      date: 'Jan 12, 3:45 PM',
      isCredit: false,
      icon: Icons.shopping_cart_outlined,
    ),
    MockTransaction(
      id: '4',
      title: 'Freelance Payment',
      subtitle: 'Income',
      amount: 750.00,
      date: 'Jan 11, 10:00 AM',
      isCredit: true,
      icon: Icons.work_outline,
    ),
    MockTransaction(
      id: '5',
      title: 'Electricity Bill',
      subtitle: 'Utilities',
      amount: 120.00,
      date: 'Jan 10, 8:00 AM',
      isCredit: false,
      icon: Icons.bolt_outlined,
    ),
    MockTransaction(
      id: '6',
      title: 'Coffee Shop',
      subtitle: 'Food & Drinks',
      amount: 6.50,
      date: 'Jan 9, 7:30 AM',
      isCredit: false,
      icon: Icons.local_cafe_outlined,
    ),
    MockTransaction(
      id: '7',
      title: 'Gym Membership',
      subtitle: 'Health',
      amount: 49.00,
      date: 'Jan 8, 6:00 AM',
      isCredit: false,
      icon: Icons.fitness_center_outlined,
    ),
    MockTransaction(
      id: '8',
      title: 'Dividend Payment',
      subtitle: 'Investment',
      amount: 180.00,
      date: 'Jan 7, 12:00 PM',
      isCredit: true,
      icon: Icons.trending_up,
    ),
  ];

  // ── Properties ───────────────────────────────────────────────────────────────
  static const properties = [
    MockProperty(
      id: '1',
      title: 'Modern Studio Apartment',
      location: 'Downtown, NYC',
      price: 450000,
      beds: 1,
      baths: 1,
      sqft: 620,
      type: 'Apartment',
      description:
          'Stunning downtown studio in the heart of Manhattan. Floor-to-ceiling '
          'windows, open kitchen, and access to rooftop terrace.',
      isFeatured: true,
    ),
    MockProperty(
      id: '2',
      title: 'Cozy Family Home',
      location: 'Suburb, Chicago',
      price: 320000,
      beds: 3,
      baths: 2,
      sqft: 1450,
      type: 'House',
      description:
          'Spacious family home with large backyard, modern kitchen, '
          'and quiet suburban neighborhood. Top-rated school district.',
    ),
    MockProperty(
      id: '3',
      title: 'Luxury Penthouse',
      location: 'Midtown, NYC',
      price: 1200000,
      beds: 3,
      baths: 2,
      sqft: 2100,
      type: 'Penthouse',
      description:
          'Exclusive penthouse with panoramic city views, private terrace, '
          'chef\'s kitchen, and 24/7 concierge service.',
      isFeatured: true,
    ),
    MockProperty(
      id: '4',
      title: 'Beach Condo',
      location: 'Miami, FL',
      price: 580000,
      beds: 2,
      baths: 2,
      sqft: 980,
      type: 'Condo',
      description:
          'Oceanfront condo with private beach access, resort-style pool, '
          'and stunning Atlantic views from every room.',
    ),
    MockProperty(
      id: '5',
      title: 'Mountain Retreat',
      location: 'Denver, CO',
      price: 275000,
      beds: 2,
      baths: 1,
      sqft: 890,
      type: 'House',
      description:
          'Charming mountain cabin surrounded by pine trees. Perfect for '
          'year-round activities — skiing in winter, hiking in summer.',
    ),
    MockProperty(
      id: '6',
      title: 'Urban Loft',
      location: 'Brooklyn, NY',
      price: 395000,
      beds: 1,
      baths: 1,
      sqft: 740,
      type: 'Loft',
      description:
          'Converted warehouse loft with exposed brick, industrial design, '
          'and a vibrant arts district neighbourhood.',
    ),
  ];

  // ── Tasks ─────────────────────────────────────────────────────────────────────
  static const tasks = [
    MockTask(
      id: '1',
      title: 'Design new landing page',
      project: 'WidgetX UI',
      priority: 'High',
      dueDate: 'Today',
      description: 'Create responsive hero + features sections.',
    ),
    MockTask(
      id: '2',
      title: 'Write unit tests',
      project: 'WidgetX UI',
      priority: 'Medium',
      dueDate: 'Tomorrow',
      description: 'Cover all button variants and input states.',
    ),
    MockTask(
      id: '3',
      title: 'Review pull requests',
      project: 'WidgetX UI',
      priority: 'High',
      dueDate: 'Today',
      isDone: true,
      description: 'Review and merge 3 open PRs.',
    ),
    MockTask(
      id: '4',
      title: 'Update documentation',
      project: 'WidgetX UI',
      priority: 'Low',
      dueDate: 'Next Week',
      description: 'Add usage examples for new components.',
    ),
    MockTask(
      id: '5',
      title: 'Deploy to staging',
      project: 'WidgetX UI',
      priority: 'High',
      dueDate: 'Today',
      description: 'Run full test suite before deploying.',
    ),
    MockTask(
      id: '6',
      title: 'Team sync meeting',
      project: 'General',
      priority: 'Medium',
      dueDate: 'Tomorrow',
      isDone: true,
      description: 'Weekly progress review with team.',
    ),
  ];

  // ── Social Posts ──────────────────────────────────────────────────────────────
  static const posts = [
    MockPost(
      id: '1',
      author: 'Alex Johnson',
      handle: '@alexjdev',
      content:
          'Just shipped the new Flutter design system! Check it out at widgetx.dev 🚀 #flutter #ui #designsystem',
      timeAgo: '2m ago',
      likes: 142,
      comments: 23,
      shares: 18,
    ),
    MockPost(
      id: '2',
      author: 'Sarah Chen',
      handle: '@sarahchen',
      content:
          'Material 3 is such a game changer for Flutter development. The dynamic color system alone is worth the upgrade.',
      timeAgo: '15m ago',
      likes: 89,
      comments: 12,
      shares: 7,
    ),
    MockPost(
      id: '3',
      author: 'Marcus Rivera',
      handle: '@mrivera',
      content:
          'Working on an open-source Flutter portfolio project. Always looking for contributors! DM me if interested.',
      timeAgo: '1h ago',
      likes: 67,
      comments: 18,
      shares: 11,
    ),
    MockPost(
      id: '4',
      author: 'Emma Williams',
      handle: '@emmaw',
      content:
          'Hot take: Riverpod is the best state management solution for Flutter in 2024. Change my mind.',
      timeAgo: '3h ago',
      likes: 203,
      comments: 45,
      shares: 32,
    ),
  ];

  // ── Restaurants ───────────────────────────────────────────────────────────────
  static const restaurants = [
    MockRestaurant(
      id: 'r1',
      name: 'Pizzeria Napoli',
      cuisine: 'Italian',
      rating: 4.8,
      deliveryTime: '25-35 min',
      minOrder: 12.0,
      category: 'Pizza',
      deliveryFee: 1.99,
      menuItems: [
        MockMenuItem(
          id: 'm1',
          name: 'Margherita Pizza',
          description: 'Classic tomato, mozzarella, fresh basil',
          price: 14.99,
          category: 'Pizza',
          isPopular: true,
        ),
        MockMenuItem(
          id: 'm2',
          name: 'Pepperoni Pizza',
          description: 'Tomato sauce, mozzarella, pepperoni',
          price: 16.99,
          category: 'Pizza',
          isPopular: true,
        ),
        MockMenuItem(
          id: 'm3',
          name: 'Tiramisu',
          description: 'Classic Italian dessert',
          price: 7.99,
          category: 'Dessert',
        ),
      ],
    ),
    MockRestaurant(
      id: 'r2',
      name: 'Tokyo Garden',
      cuisine: 'Japanese',
      rating: 4.6,
      deliveryTime: '30-45 min',
      minOrder: 15.0,
      category: 'Sushi',
      deliveryFee: 2.99,
      menuItems: [
        MockMenuItem(
          id: 'm4',
          name: 'Salmon Nigiri',
          description: '2 pieces of fresh salmon over rice',
          price: 8.99,
          category: 'Sushi',
          isPopular: true,
        ),
        MockMenuItem(
          id: 'm5',
          name: 'Dragon Roll',
          description: 'Avocado, shrimp tempura, cucumber',
          price: 13.99,
          category: 'Roll',
          isPopular: true,
        ),
        MockMenuItem(
          id: 'm6',
          name: 'Miso Soup',
          description: 'Tofu, wakame, green onion',
          price: 3.99,
          category: 'Soup',
        ),
      ],
    ),
    MockRestaurant(
      id: 'r3',
      name: 'Burger Republic',
      cuisine: 'American',
      rating: 4.5,
      deliveryTime: '20-30 min',
      minOrder: 8.0,
      category: 'Burgers',
      deliveryFee: 0.99,
      menuItems: [
        MockMenuItem(
          id: 'm7',
          name: 'Classic Cheeseburger',
          description: 'Beef patty, cheddar, lettuce, tomato',
          price: 12.99,
          category: 'Burger',
          isPopular: true,
        ),
        MockMenuItem(
          id: 'm8',
          name: 'Crispy Fries',
          description: 'Golden fries with sea salt',
          price: 4.99,
          category: 'Sides',
        ),
        MockMenuItem(
          id: 'm9',
          name: 'Chocolate Shake',
          description: 'Thick creamy milkshake',
          price: 5.99,
          category: 'Drinks',
          isPopular: true,
        ),
      ],
    ),
  ];

  // ── Notifications ──────────────────────────────────────────────────────────────
  static const notifications = [
    MockNotification(
      id: 'n1',
      title: 'Order Delivered',
      message: 'Your order #1234 has been delivered successfully.',
      timeAgo: '5m ago',
      icon: Icons.check_circle_outline,
    ),
    MockNotification(
      id: 'n2',
      title: 'Payment Received',
      message: 'Freelance payment of \$750 has been credited.',
      timeAgo: '1h ago',
      icon: Icons.attach_money,
      isRead: true,
    ),
    MockNotification(
      id: 'n3',
      title: 'New Message',
      message: 'Sarah Chen sent you a message.',
      timeAgo: '2h ago',
      icon: Icons.message_outlined,
    ),
    MockNotification(
      id: 'n4',
      title: 'Task Due Soon',
      message: '"Design landing page" is due today.',
      timeAgo: '3h ago',
      icon: Icons.assignment_outlined,
      isRead: true,
    ),
    MockNotification(
      id: 'n5',
      title: 'Property Alert',
      message: 'A new property matching your search was listed in NYC.',
      timeAgo: '1d ago',
      icon: Icons.home_outlined,
      isRead: true,
    ),
  ];

  // ── Chat messages ──────────────────────────────────────────────────────────────
  static const chatMessages = [
    MockChatMessage(
      id: 'c1',
      author: 'Sarah Chen',
      message: 'Hey! Did you see the new design system?',
      timeAgo: '10:32 AM',
      isMine: false,
    ),
    MockChatMessage(
      id: 'c2',
      author: 'Me',
      message: 'Yes! It looks incredible. The components are so clean.',
      timeAgo: '10:33 AM',
      isMine: true,
    ),
    MockChatMessage(
      id: 'c3',
      author: 'Sarah Chen',
      message: 'The dark mode support is chef\'s kiss 👌',
      timeAgo: '10:34 AM',
      isMine: false,
    ),
    MockChatMessage(
      id: 'c4',
      author: 'Me',
      message: 'Totally! I\'m going to use it in my next project.',
      timeAgo: '10:35 AM',
      isMine: true,
    ),
    MockChatMessage(
      id: 'c5',
      author: 'Sarah Chen',
      message: 'Let me know if you need help getting started!',
      timeAgo: '10:36 AM',
      isMine: false,
    ),
  ];

  // ── Hotel Rooms ────────────────────────────────────────────────────────────────
  static const hotelRooms = [
    MockHotelRoom(
      id: 'room1',
      name: 'Deluxe Room',
      description: 'Comfortable room with city view, king bed, and modern amenities.',
      pricePerNight: 189.0,
      capacity: 2,
      amenities: ['WiFi', 'TV', 'Mini Bar', 'Safe', 'Air Conditioning'],
    ),
    MockHotelRoom(
      id: 'room2',
      name: 'Superior Suite',
      description: 'Spacious suite with separate living area, bathtub, and premium toiletries.',
      pricePerNight: 299.0,
      capacity: 3,
      amenities: ['WiFi', 'TV', 'Mini Bar', 'Safe', 'Bathtub', 'Balcony'],
    ),
    MockHotelRoom(
      id: 'room3',
      name: 'Penthouse Suite',
      description: 'Luxurious penthouse with panoramic views, private terrace, and butler service.',
      pricePerNight: 599.0,
      capacity: 4,
      amenities: ['WiFi', 'TV', 'Full Bar', 'Safe', 'Bathtub', 'Private Terrace', 'Butler'],
    ),
  ];
}
