namespace SystemBenchmarking.Shared
{
    public static class Extensions
    {
        #region Universal

        public const double RADIANS_MULTIPLICATION = Math.PI / 180;

        public static double ToRadians(this double val)
            => RADIANS_MULTIPLICATION * val;

        public static void Swap<T>(this T[] collection, int idx1, int idx2)
        {
            var tmp = collection[idx1];
            collection[idx1] = collection[idx2];
            collection[idx2] = tmp;
        }

        #endregion
    }
}
