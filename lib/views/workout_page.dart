import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';
import 'dashboard_page.dart';
import 'nutrition_page.dart';
import 'focus_workout_page.dart';

import 'package:provider/provider.dart';
import '../controllers/workout_controller.dart';
import '../models/exercise_model.dart';
import '../services/notification_service.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({super.key});

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  // Colors based on Tailwind config
  final Color background = const Color(0xFFF8F9FF);
  final Color surface = const Color(0xFFF8F9FF);
  final Color onSurface = const Color(0xFF0B1C30);
  final Color onSurfaceVariant = const Color(0xFF45464D);
  final Color secondary = const Color(0xFFB61722);
  final Color outline = const Color(0xFF76777D);
  final Color surfaceContainerHigh = const Color(0xFFDCE9FF);
  final Color surfaceContainer = const Color(0xFFE5EEFF);
  final Color surfaceVariant = const Color(0xFFD3E4FE);
  final Color surfaceContainerHighest = const Color(0xFFD3E4FE);
  final Color primaryContainer = const Color(0xFF131B2E);
  final Color onPrimaryContainer = const Color(0xFF7C839B);
  final Color surfaceContainerLow = const Color(0xFFEFF4FF);
  final Color tertiaryFixedDim = const Color(0xFFADC6FF);
  final Color onTertiaryFixed = const Color(0xFF001A42);
  final Color secondaryFixedDim = const Color(0xFFFFB3AD);
  final Color primary = const Color(0xFF000000);

  int _selectedIndex = 2; // Workouts page index
  final TextEditingController _searchController = TextEditingController();

  void _performSearch(String query) {
    context.read<WorkoutController>().fetchExercises(query);
  }

  @override
  Widget build(BuildContext context) {
    final workoutController = context.watch<WorkoutController>();
    final isLoading = workoutController.isLoading;
    final exercises = workoutController.exercises;
    final searchQuery = _searchController.text;

    return Scaffold(
      backgroundColor: background,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: surface.withValues(alpha: 0.8),
        elevation: 0,
        scrolledUnderElevation: 0,
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(color: Colors.transparent),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Center(
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: secondary.withValues(alpha: 0.2), width: 2),
                image: const DecorationImage(
                  image: NetworkImage(
                      'https://lh3.googleusercontent.com/aida-public/AB6AXuDsXZkf_AmUksdPshLHb4x72WDyC414x6ywCr9aHYe24m1VwFlQL65mdWPRoiv29GUhwzs6FQSAVr6TIOF48K5fssn7XNxOqFzMS1acNkXrc9wLdm784piCcTdV2hLZrrHglxBTt1AY5DSGCJkIw2ZT0TDzigpOUr6V-xNy7M4ghzRXx23QIp3f_ZFeGw5yP4TJwm9iZLk4U2q_vJodpbBhijKVvdm-mORP0ZEs9UAGkzj6piy6zl7A'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        title: Row(
          children: [
            Text(
              'Discovery',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: secondary, // Dark mode color would be secondaryFixedDim
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: Icon(Icons.notifications_none, color: primary),
              onPressed: () {
                NotificationService().showNotification(
                  id: 1,
                  title: 'Workout Reminder',
                  body: 'Time to crush your goals! Let\'s get moving!',
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Notification triggered!')),
                );
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + kToolbarHeight + 24,
          bottom: 104.0, // Space for BottomNavigationBar
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1280),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(color: surfaceVariant),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.03),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: _searchController,
                            onSubmitted: _performSearch,
                            style: GoogleFonts.plusJakartaSans(
                              color: onSurface,
                              fontSize: 15,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Search workouts...',
                              hintStyle: GoogleFonts.plusJakartaSans(
                                color: onSurfaceVariant.withValues(alpha: 0.5),
                                fontSize: 15,
                              ),
                              prefixIcon: Icon(Icons.search, color: onSurfaceVariant.withValues(alpha: 0.5)),
                              suffixIcon: IconButton(
                                icon: Icon(Icons.mic, color: secondary),
                                onPressed: () {},
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [secondary, secondary.withValues(alpha: 0.8)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: secondary.withValues(alpha: 0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.search, color: Colors.white),
                          onPressed: () => _performSearch(_searchController.text),
                        ),
                      ),
                    ],
                  ),
                ),

                if (isLoading)
                  const Padding(
                    padding: EdgeInsets.all(32.0),
                    child: Center(child: CircularProgressIndicator()),
                  )
                else if (searchQuery.isNotEmpty && exercises.isEmpty)
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Center(
                      child: Text(
                        'No exercises found for "$searchQuery".',
                        style: GoogleFonts.plusJakartaSans(color: onSurfaceVariant),
                      ),
                    ),
                  )
                else if (searchQuery.isNotEmpty && exercises.isNotEmpty)
                  _buildSearchResults(exercises)
                else ...[
                  // Featured Challenges
                Padding(
                  padding: const EdgeInsets.only(bottom: 32.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Featured Challenges',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: primary,
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: Text(
                                'View All',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: secondary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 380,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          children: [
                            _buildChallengeCard(
                              title: '30-Day Shred',
                              users: '12.4k users participating',
                              badgeText: 'Most Popular',
                              badgeColor: secondary,
                              badgeTextColor: Colors.white,
                              imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAgMU_sZUUomPD7Lm3Mbs9FEuGIYEmbo1lFC6zofp-WmAi2OUe0tSD5dLSZ7tgilkeMLuoJIlJOoVjHO4OpfjpBNQwZB35xORiQxHVcXnroFeOs93GtTDeGSN9UwPdonFD3IBMdU7IhOoTaxXB2Dhmya2pyJbZ4xCxY821f1rC_cS2RceoTJ2EGgHSl49FXJwgZFOCvFpCZF1XLkXO18fp-rXBACRIlSMgsuhEfuV13M8PliGUS7JMN',
                              progress: 0.65,
                            ),
                            const SizedBox(width: 16),
                            _buildChallengeCard(
                              title: 'Summer Ready',
                              users: '8.2k users participating',
                              badgeText: 'New Program',
                              badgeColor: tertiaryFixedDim,
                              badgeTextColor: onTertiaryFixed,
                              imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAp56LzLr32jMZISjZDqsez8pDLpxjHwba5dXX6_-87CE4QywFDi9m3YM2yr2nbXzn_6c5bRwNEtP7afroTlpIceIl_MxSDXSJyhUThVTM5W-cUUsRaMf1tah3DVStMH3JaoZ-gG1I1bQhEmEhE0QRSr_CIofKXS1eqiXv1D_AecWT74o9jOR07phxNxsrJWu6anQWHeyA9vxnwnjPg5bKLavfxZSzreSLJLZIfALGlQ2zHWB5nEKT1',
                              progress: 0.30,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Body Focus Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Text(
                          'Focus Your Training',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: primary,
                          ),
                        ),
                      ),
                      GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.75,
                        children: [
                          _buildFocusCard(
                            title: 'Abs for Beginners',
                            time: '15 min',
                            level: 'Light',
                            imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCjMM9XRkBXK5BVjUyKX_3Wbhoo3UaOXGOUrrdcOkGj3WZxS9UllRX1ySJqw53Ye1E6gOL2kHIRsUSVKWherqnMl1dcH98S2f42LFOMgBtAS5O9jA5exuJs9xHJJWypdVugDwtwwIwHsZcB5NbAXehXlNLiAm9Xt-kS2Aojby96oL5vIv9usx8bE2zplH8AmiDwKGZU9XzUHRYk7afEoZSB2fZNIQUJuvrnNGGGYvFYrB5__LadOtho',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const FocusWorkoutPage(
                                    title: 'Abs for Beginners',
                                    targetMuscle: 'abdominals',
                                    imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCjMM9XRkBXK5BVjUyKX_3Wbhoo3UaOXGOUrrdcOkGj3WZxS9UllRX1ySJqw53Ye1E6gOL2kHIRsUSVKWherqnMl1dcH98S2f42LFOMgBtAS5O9jA5exuJs9xHJJWypdVugDwtwwIwHsZcB5NbAXehXlNLiAm9Xt-kS2Aojby96oL5vIv9usx8bE2zplH8AmiDwKGZU9XzUHRYk7afEoZSB2fZNIQUJuvrnNGGGYvFYrB5__LadOtho',
                                    category: 'Core Strength',
                                  ),
                                ),
                              );
                            },
                          ),
                          _buildFocusCard(
                            title: 'Powerful Chest',
                            time: '25 min',
                            level: 'Pro',
                            imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCyiyRoKPuqt_3DmTLzJqS6P_KhPcB6hqU21MyyDia8wJCqj-seoV8FrYtzDwADaKT4Z_IvYbeG3pPM6YOIsja4nY5mLBa8KSrkqB-10EYrgn71qyW6k1P7qvcyjWqsMuh3Xc0pzCqnsNmZzaVqfERt23u5imGSCZUfrD3x_Iqq1Tnljgwb-eEOQkSaX74pF2IzK_2Rxa96fM9o0kzka1KWKYAwWp2Dc67XDql7NmSL6qR6EmHbopEX',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const FocusWorkoutPage(
                                    title: 'Powerful Chest',
                                    targetMuscle: 'chest',
                                    imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCyiyRoKPuqt_3DmTLzJqS6P_KhPcB6hqU21MyyDia8wJCqj-seoV8FrYtzDwADaKT4Z_IvYbeG3pPM6YOIsja4nY5mLBa8KSrkqB-10EYrgn71qyW6k1P7qvcyjWqsMuh3Xc0pzCqnsNmZzaVqfERt23u5imGSCZUfrD3x_Iqq1Tnljgwb-eEOQkSaX74pF2IzK_2Rxa96fM9o0kzka1KWKYAwWp2Dc67XDql7NmSL6qR6EmHbopEX',
                                    category: 'Upper Body',
                                  ),
                                ),
                              );
                            },
                          ),
                          _buildFocusCard(
                            title: 'Arm Sculpting',
                            time: '20 min',
                            level: 'Medium',
                            imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAkEUYAxHabAlYVi62bccDRx0CReL78dVw7FGlzoNdqH_9F9hdTumuw_fXL_zcHL8VYB76ZT68PFKyztAohUwGC1PUBaZ385kJeZeub9N2RXOiXT13eh2semzNbbCOfM8xONrmzahH4KoEuoQsFIiUGNRR5Ky2Lz5zycc5YO-tqeU95zRDif_qcI9GWnhprlbVOzl6OC8D-OXUx0oZ682fYqyBqu4IfUy84T4LqkggOXhWhH58ZB6RM',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const FocusWorkoutPage(
                                    title: 'Arm Sculpting',
                                    targetMuscle: 'biceps',
                                    imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAkEUYAxHabAlYVi62bccDRx0CReL78dVw7FGlzoNdqH_9F9hdTumuw_fXL_zcHL8VYB76ZT68PFKyztAohUwGC1PUBaZ385kJeZeub9N2RXOiXT13eh2semzNbbCOfM8xONrmzahH4KoEuoQsFIiUGNRR5Ky2Lz5zycc5YO-tqeU95zRDif_qcI9GWnhprlbVOzl6OC8D-OXUx0oZ682fYqyBqu4IfUy84T4LqkggOXhWhH58ZB6RM',
                                    category: 'Upper Body',
                                  ),
                                ),
                              );
                            },
                          ),
                          _buildFocusCard(
                            title: 'Leg Day Pro',
                            time: '45 min',
                            level: 'Expert',
                            imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAte_SmrAvlkGgzqyXVwY-mCgQK06mQprVOpPMkJiyVaGxyFtUabtwEnpYkAlkkQLOEJRlvBey1Yxe7Ihvc96DvD6JiTIvzQvKUNARrSpeoTePwTwd9rrk7NkDB9hlx1i6wzBWLpXbshKrp895la66TTCUaVCp5JsL9Ov0YuafUgYfS7ITKnmSm3fpK-R0IGc6HnQ3WtjbKyNoAMQ2YNVI4LiWokf9HjDOaeG7XoYxul7IgJtC6yg3y',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const FocusWorkoutPage(
                                    title: 'Leg Day Pro',
                                    targetMuscle: 'quadriceps',
                                    imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAte_SmrAvlkGgzqyXVwY-mCgQK06mQprVOpPMkJiyVaGxyFtUabtwEnpYkAlkkQLOEJRlvBey1Yxe7Ihvc96DvD6JiTIvzQvKUNARrSpeoTePwTwd9rrk7NkDB9hlx1i6wzBWLpXbshKrp895la66TTCUaVCp5JsL9Ov0YuafUgYfS7ITKnmSm3fpK-R0IGc6HnQ3WtjbKyNoAMQ2YNVI4LiWokf9HjDOaeG7XoYxul7IgJtC6yg3y',
                                    category: 'Lower Body',
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 32),

                // Workout Collections
                Padding(
                  padding: const EdgeInsets.only(bottom: 32.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Workout Collections',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: primary,
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: Text(
                                'See All',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: secondary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 80,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          children: [
                            _buildCollectionCard(
                              title: 'HIIT Essentials',
                              subtitle: '12 Workouts',
                              icon: Icons.bolt,
                              iconColor: Colors.white,
                              iconBgColor: secondary,
                            ),
                            const SizedBox(width: 16),
                            _buildCollectionCard(
                              title: 'Yoga for Recovery',
                              subtitle: '8 Sessions',
                              icon: Icons.self_improvement,
                              iconColor: onTertiaryFixed,
                              iconBgColor: tertiaryFixedDim,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // CTA Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: primaryContainer,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Don\'t know where to start?',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Take our 2-minute quiz and get a personalized training plan designed for your goals.',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: onPrimaryContainer,
                              ),
                            ),
                            const SizedBox(height: 24),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: secondary,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                textStyle: GoogleFonts.plusJakartaSans(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                                shadowColor: secondary.withValues(alpha: 0.5),
                                elevation: 8,
                              ),
                              child: const Text('Start Fitness Quiz'),
                            ),
                          ],
                        ),
                        Positioned(
                          right: -40,
                          bottom: -40,
                          child: Opacity(
                            opacity: 0.2,
                            child: Transform.rotate(
                              angle: 0.2, // ~12 degrees
                              child: const Icon(
                                Icons.fitness_center,
                                size: 180,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 32),
                ], // End of conditional children
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: surface.withValues(alpha: 0.8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.transparent,
              elevation: 0,
              currentIndex: _selectedIndex,
              selectedItemColor: secondary,
              unselectedItemColor: outline,
              selectedFontSize: 12,
              unselectedFontSize: 12,
              selectedLabelStyle: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700),
              unselectedLabelStyle: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w500),
              onTap: (index) {
                if (index == _selectedIndex) return;
                setState(() {
                  _selectedIndex = index;
                });
                
                if (index == 0) {
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, _, _) => const DashboardPage(),
                      transitionDuration: Duration.zero,
                    ),
                  );
                } else if (index == 1) {
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, _, _) => const NutritionPage(),
                      transitionDuration: Duration.zero,
                    ),
                  );
                }
                // Handle index 3 if needed
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Padding(padding: EdgeInsets.only(bottom: 4), child: Icon(Icons.home, size: 24)),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Padding(padding: EdgeInsets.only(bottom: 4), child: Icon(Icons.restaurant, size: 24)),
                  label: 'Nutrition',
                ),
                BottomNavigationBarItem(
                  icon: Padding(padding: EdgeInsets.only(bottom: 4), child: Icon(Icons.fitness_center, size: 24)),
                  label: 'Workouts',
                ),
                BottomNavigationBarItem(
                  icon: Padding(padding: EdgeInsets.only(bottom: 4), child: Icon(Icons.show_chart, size: 24)),
                  label: 'Progress',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChallengeCard({
    required String title,
    required String users,
    required String badgeText,
    required Color badgeColor,
    required Color badgeTextColor,
    required String imageUrl,
    required double progress,
  }) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              primary.withValues(alpha: 0.9),
              primary.withValues(alpha: 0.2),
              Colors.transparent,
            ],
          ),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: badgeColor,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                badgeText.toUpperCase(),
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: badgeTextColor,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              users,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.white.withValues(alpha: 0.8),
              ),
            ),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.white.withValues(alpha: 0.2),
                color: secondary,
                minHeight: 6,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: secondary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                child: Text(
                  'Join Challenge',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFocusCard({
    required String title,
    required String time,
    required String level,
    required String imageUrl,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: surfaceVariant.withValues(alpha: 0.5)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 4,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: surfaceContainerHigh,
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primary,
              ),
            ),
            const SizedBox(height: 4),
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Icon(Icons.schedule, size: 16, color: onSurfaceVariant),
                  const SizedBox(width: 4),
                  Text(
                    time,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      color: onSurfaceVariant,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      '•',
                      style: TextStyle(
                        fontSize: 12,
                        color: onSurfaceVariant.withValues(alpha: 0.3),
                      ),
                    ),
                  ),
                  Text(
                    level,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      color: onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCollectionCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
  }) {
    return Container(
      width: 240,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: surfaceContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 32),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primary,
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    color: onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults(List<ExerciseModel> exercises) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Search Results',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: primary,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    _searchController.clear();
                    context.read<WorkoutController>().fetchExercises('');
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    'Clear',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: secondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: exercises.length,
            itemBuilder: (context, index) {
              final exercise = exercises[index];
              return _buildExerciseCard(exercise);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseCard(ExerciseModel exercise) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: surfaceVariant.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (exercise.imageUrl != null) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                exercise.imageUrl!,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const SizedBox(),
              ),
            ),
            const SizedBox(height: 16),
          ],
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  exercise.name,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: primary,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: surfaceContainerHigh,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  exercise.difficulty.toUpperCase(),
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: secondaryFixedDim.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  exercise.muscle,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: secondary,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: tertiaryFixedDim.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  exercise.type,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: onTertiaryFixed,
                  ),
                ),
              ),
            ],
          ),

          if (exercise.safetyInfo != null && exercise.safetyInfo!.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              'Safety Info',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.red[800],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              exercise.safetyInfo!,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                color: onSurfaceVariant,
              ),
            ),
          ],
          if (exercise.equipments != null || exercise.equipment != null) ...[
            const SizedBox(height: 12),
            Text(
              'Equipment',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: primary,
              ),
            ),
            const SizedBox(height: 4),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: () {
                final eqData = exercise.equipments ?? exercise.equipment;
                List<String> eqList = [];
                if (eqData is List) {
                  eqList = eqData.map((e) => e.toString()).toList();
                } else if (eqData is String) {
                  eqList = [eqData];
                }
                return eqList.map<Widget>((eq) => Chip(
                  label: Text(
                    eq,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      color: onSurfaceVariant,
                    ),
                  ),
                  backgroundColor: surfaceContainer,
                  side: BorderSide.none,
                  padding: EdgeInsets.zero,
                )).toList();
              }(),
            ),
          ],
        ],
      ),
    );
  }
}
